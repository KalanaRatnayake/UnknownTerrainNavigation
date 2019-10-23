#include <global_path_planner.h>

/*
/ constructor
*/

global_path_planner::global_path_planner(){}

void global_path_planner::update_tree(octomap::OcTree* receivedTree){
    tree_oct = receivedTree;
}

void global_path_planner::update_position(octomap::point3d &position){
    currentPosition = position;
}

void global_path_planner::update_goal(octomap::point3d &position){
    goal = position;
}

/*
/ Astar algorithm to calculate the path. grid is built by iterating through the voxel map
*/

bool isValid(int row, int col) {
	return (row >= 0) && (row < ROW) && (col >= 0) && (col < COL); 
} 

bool isUnBlocked(int grid[][COL], int row, int col) { 
	if (grid[row][col] == 1) return (true); else return (false); 
}

bool isDestination(int row, int col, global_path_planner::Pair dest) { 
	if (row == dest.first && col == dest.second) return (true); else return (false); 
} 

double calculateHValue(int row, int col, global_path_planner::Pair dest) {
	return ((double) std::sqrt((row-dest.first)*(row-dest.first) + (col-dest.second)*(col-dest.second))); 
} 

void tracePath(global_path_planner::cell cellDetails[][COL], global_path_planner::Pair dest, std::vector<octomap::point3d> &outPath){
	int row = dest.first; 
	int col = dest.second; 

	std::stack<global_path_planner::Pair> PathStack;
    std::vector<octomap::point3d> path;

	while (!(cellDetails[row][col].parent_i == row && cellDetails[row][col].parent_j == col )) { 
		PathStack.push(std::make_pair (row, col)); 
		int temp_row = cellDetails[row][col].parent_i; 
		int temp_col = cellDetails[row][col].parent_j; 
		row = temp_row; 
		col = temp_col; 
	} 

	PathStack.push(std::make_pair (row, col)); 
	while (!PathStack.empty()) { 
		std::pair<int,int> p = PathStack.top(); 
		PathStack.pop();
        octomap::point3d position = octomap::point3d(p.second, p.first, 0);
        outPath.push_back(position); 
	}
} 

bool global_path_planner::search(int grid[][COL], global_path_planner::Pair src, global_path_planner::Pair dest, std::vector<octomap::point3d> &outPath) {
	if (isValid (src.first, src.second) == false) return false;
	if (isValid (dest.first, dest.second) == false) return false;
	if (isUnBlocked(grid, src.first, src.second) == false || isUnBlocked(grid, dest.first, dest.second) == false) return false; 
	if (isDestination(src.first, src.second, dest) == true) return false; 

	bool closedList[ROW][COL]; 
	memset(closedList, false, sizeof (closedList)); 
	global_path_planner::cell cellDetails[ROW][COL]; 
	int i, j; 

	for (i=0; i<ROW; i++) { 
		for (j=0; j<COL; j++) { 
			cellDetails[i][j].f = FLT_MAX; 
			cellDetails[i][j].g = FLT_MAX; 
			cellDetails[i][j].h = FLT_MAX; 
			cellDetails[i][j].parent_i = -1; 
			cellDetails[i][j].parent_j = -1; 
		} 
	} 

	i = src.first, j = src.second;

	cellDetails[i][j].f = 0.0; 
	cellDetails[i][j].g = 0.0; 
	cellDetails[i][j].h = 0.0; 
	cellDetails[i][j].parent_i = i; 
	cellDetails[i][j].parent_j = j; 

	std::set<global_path_planner::pPair> openList; 
	openList.insert(std::make_pair (0.0, std::make_pair (i, j))); 
	bool foundDest = false; 

	while (!openList.empty()) { 
		global_path_planner::pPair p = *openList.begin(); 
		openList.erase(openList.begin()); 
		i = p.second.first; 
		j = p.second.second; 
		closedList[i][j] = true; 
	
		double gNew, hNew, fNew;

        int array [8][2] = {{i-1, j-1},	{i-1, j  }, {i-1, j+1},
							{i  , j-1}, 		    {i  , j+1},  
							{i+1, j-1},	{i+1, j  }, {i+1, j+1} };

        for (int a = 0; a < 8; a++ ) {
            if (isValid(array[a][0], array[a][1]) == true) { 
                if (isDestination(array[a][0], array[a][1], dest) == true) {  
                    cellDetails[array[a][0]][array[a][1]].parent_i = i; 
                    cellDetails[array[a][0]][array[a][1]].parent_j = j;
                    tracePath (cellDetails, dest, outPath); 
                    foundDest = true; 
                    return true; 
                } else if (closedList[array[a][0]][array[a][1]] == false && isUnBlocked(grid, array[a][0], array[a][1]) == true) { 
                    gNew = cellDetails[i][j].g + 1.0; 
                    hNew = calculateHValue (array[a][0], array[a][1], dest); 
                    fNew = gNew + hNew; 
    
                    if (cellDetails[array[a][0]][array[a][1]].f == FLT_MAX || cellDetails[array[a][0]][array[a][1]].f > fNew) { 
                        openList.insert( std::make_pair(fNew, std::make_pair(array[a][0], array[a][1]))); 
                        cellDetails[array[a][0]][array[a][1]].f = fNew; 
                        cellDetails[array[a][0]][array[a][1]].g = gNew; 
                        cellDetails[array[a][0]][array[a][1]].h = hNew; 
                        cellDetails[array[a][0]][array[a][1]].parent_i = i; 
                        cellDetails[array[a][0]][array[a][1]].parent_j = j; 
                    } 
                } 
            }
        }  
	} 
	if (foundDest == false)	return false; 
}

/*
/ calculate the grid by iterating through the map. on ground, look for unoccupied areas which means holes and on 
/ surrounding space, looks for occupied nodes which mean obstacles
*/ 

void global_path_planner::buildMap(int (&outGrid)[INITROW][INITCOL]){
	// Description of the Grid- {1--> not occupied} {0--> occupied} 

	//initialize all to not occupied state
	for (int i = 0; i < INITROW; i++){
		for (int j = 0; j < INITCOL; j++){
			outGrid[i][j] = 1;
		}
	}

	for(octomap::OcTree::leaf_iterator it = tree_oct->begin_leafs(), end = tree_oct->end_leafs(); it!=end; ++it){
        octomap::OcTreeNode* key = tree_oct->search(it.getX(), it.getY(), it.getZ());

		if(tree_oct->isNodeOccupied(key)){   
			if ((it.getZ()>currentPosition.z()) && (it.getZ()<(currentPosition.z()+HEIGHT))) {
				if ((it.getX()>MAPLOW) && (it.getX()<MAPHIGH)){
					if ((it.getY()>MAPLOW) && (it.getY()<MAPHIGH)){

						int x = (int) (it.getX() + OFFSET)*INVCELL;
						int y = (int) (it.getY() + OFFSET)*INVCELL;
					
						outGrid[y][x] = 0;
					}
				} 
			}
		} else {
			if (it.getZ()==(currentPosition.z()-CELL)) {
				if ((it.getX()>MAPLOW) && (it.getX()<MAPHIGH)){
					if ((it.getY()>MAPLOW) && (it.getY()<MAPHIGH)){

						int x = (int) (it.getX() + OFFSET)*INVCELL;
						int y = (int) (it.getY() + OFFSET)*INVCELL;
					
						outGrid[y][x] = 0;
					}
				} 
			}
		}
    }
}

/*
/ calculates a padding around the obstacles in the map so robot can act as a point object
*/

void global_path_planner::preprocessMap(int (&inGrid)[INITROW][INITCOL], int (&outGrid)[ROW][COL]){
	// Description of the Grid- {1--> not occupied} {0--> occupied} 
	int paddedGrid [PADROW][PADCOL];

	//initialize all to not occupied state
	for (int i = 0; i < PADROW; i++){
		for (int j = 0; j < PADCOL; j++){
			paddedGrid[i][j] = 1;
		}
	}

	//assign occupied space with a padding of 4 blocks
	for (int i = 0; i < INITROW; i++){
		for (int j = 0; j < INITCOL; j++){
			if (inGrid[i][j] == 0){

				int x = i+4;
				int y = j+4;

				int mask [81][2] = {{x-4, j-4}, {x-4, j-3}, {x-4, j-2}, {x-4, j-1}, {x-4, j  }, {x-4, j+1}, {x-4, j+2}, {x-4, j+3}, {x-4, j+4},
									{x-3, j-4}, {x-3, j-3}, {x-3, j-2}, {x-3, j-1}, {x-3, j  }, {x-3, j+1}, {x-3, j+2}, {x-3, j+3}, {x-3, j+4},
									{x-2, j-4}, {x-2, j-3}, {x-2, j-2}, {x-2, j-1}, {x-2, j  }, {x-2, j+1}, {x-2, j+2}, {x-2, j+3}, {x-2, j+4},
									{x-1, j-4}, {x-1, j-3}, {x-1, j-2}, {x-1, j-1}, {x-1, j  }, {x-1, j+1}, {x-1, j+2}, {x-1, j+3}, {x-1, j+4},
									{x  , j-4}, {x  , j-3}, {x  , j-2}, {x  , j-1}, {x  , j  }, {x  , j+1}, {x  , j+2}, {x  , j+3}, {x  , j+4},
									{x+1, j-4}, {x+1, j-3}, {x+1, j-2}, {x+1, j-1}, {x+1, j  }, {x+1, j+1}, {x+1, j+2}, {x+1, j+3}, {x+1, j+4},
									{x+2, j-4}, {x+2, j-3}, {x+2, j-2}, {x+2, j-1}, {x+2, j  }, {x+2, j+1}, {x+2, j+2}, {x+2, j+3}, {x+2, j+4},
									{x+3, j-4}, {x+3, j-3}, {x+3, j-2}, {x+3, j-1}, {x+3, j  }, {x+3, j+1}, {x+3, j+2}, {x+3, j+3}, {x+3, j+4},
									{x+4, j-4}, {x+4, j-3}, {x+4, j-2}, {x+4, j-1}, {x+4, j  }, {x+4, j+1}, {x+4, j+2}, {x+4, j+3}, {x+4, j+4}
									};

				for (int a = 0; a < 81; a++){
					paddedGrid[mask[a][0]][mask[a][1]] = 0;
				}
				
			}
		}
	}

	for (int i = 0; i < ROW; i++){
		for (int j = 0; j < COL; j++){
			outGrid[i][j] = paddedGrid[i+8][j+8];
		}
	}
}

/*
/ removes intermediate points which are on the same straight line
*/

void global_path_planner::cleanPath(std::vector<octomap::point3d> path){
	for (int i = 1; i < (path.size()-1); i++){
		if ((path[i-1].y()== path[i].y()) && (path[i].y() == path[i+1].y())){
			path.erase(path.begin()+i-1);
		} else if (((path[i-1].x()== path[i].x()) && (path[i].x() == path[i+1].x()))){
			path.erase(path.begin()+i-1);
		} else {
			float m1 = (path[i].y() - path[i-1].y())/(path[i].x() - path[i-1].x());
			float m2 = (path[i+1].y() - path[i].y())/(path[i+1].x() - path[i].x());
			if (m1==m2) path.erase(path.begin()+i-1);
		}	
	}
}

void global_path_planner::saveOctomap(const std::string &filename){
	tree_oct->write(filename);
}