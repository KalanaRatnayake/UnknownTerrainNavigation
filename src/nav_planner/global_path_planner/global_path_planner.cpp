#include <global_path_planner.h>

/*
/ constructor
*/

// Description of the Grid- {1--> not occupied} {0--> occupied}

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

bool isUnBlocked(std::vector<std::vector<int> > &grid, int row, int col) { 
	if (grid[row][col] == 1) return (true); else return (false); 
}

bool isDestination(int row, int col, global_path_planner::Pair dest) { 
	if (row == dest.first && col == dest.second) return (true); else return (false); 
} 

double calculateHValue(int row, int col, global_path_planner::Pair dest) {
	return ((double) std::sqrt((row-dest.first)*(row-dest.first) + (col-dest.second)*(col-dest.second))); 
} 

void tracePath( std::vector<std::vector<global_path_planner::cell> > &cellDetails, global_path_planner::Pair dest, std::vector<octomap::point3d> &outPath){
	int row = dest.first; 
	int col = dest.second; 

	std::stack<global_path_planner::Pair> PathStack;
	outPath.clear();

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
        octomap::point3d position (p.second, p.first, 0);
        outPath.push_back(position); 
	}
} 

bool global_path_planner::search(std::vector<std::vector<int> > &grid, global_path_planner::Pair src, global_path_planner::Pair dest, std::vector<octomap::point3d> &outPath) {
	if (isValid (src.first, src.second) == false) return false;
	if (isValid (dest.first, dest.second) == false) return false;
	if (isUnBlocked(grid, src.first, src.second) == false || isUnBlocked(grid, dest.first, dest.second) == false) return false; 
	if (isDestination(src.first, src.second, dest) == true) return false; 

	std::vector<std::vector<bool> > closedList( ROW, std::vector<bool> (COL, false));
	std::vector<std::vector<global_path_planner::cell> > cellDetails( ROW, std::vector<global_path_planner::cell> (COL));
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

        int array [8][2] = {{i-1, j}, {i+1, j}, {i, j+1}, {i, j-1}, {i-1, j+1}, {i-1, j-1}, {i+1, j+1}, {i+1, j-1}};

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

void global_path_planner::buildMap(std::vector<std::vector<int> > &initialGrid, std::vector<std::vector<int> > &processedGrid){
	// Description of the Grid- {1--> not occupied} {0--> occupied}
	std::vector<std::vector<int> > paddedGrid( PADROW, std::vector<int> (PADCOL, 1));

	//inspect surrounding
	float lower = currentPosition.z() + UNITOFFSET;
	float upper = currentPosition.z() + HEIGHT;

	for (float z=lower; z<upper; z+=CELL){
        for (float x=MAPLOW; x<MAPHIGH; x+=CELL){
            for (float y=MAPLOW; y<MAPHIGH; y+=CELL){
                if (tree_oct->search(x, y, z)){
                    octomap::OcTreeNode* key = tree_oct->search(x, y, z);

					if(tree_oct->isNodeOccupied(key)){
						int xN = (int) ((x + OFFSET)*INVCELL);
						int yN = (int) ((y + OFFSET)*INVCELL);

						initialGrid[yN][xN] = 0;

						int xlow = xN;
						int xhigh = xN+MASKSIDE;
						int ylow = yN;
						int yhigh = yN+MASKSIDE;

						for (int a=xlow; a<xhigh; a++){
							for (int b=ylow; b<yhigh; b++){
								paddedGrid[b][a] = 0;
							}
						}
					}
                }
            }
        }
    }

	// //inspect floor

	float zf = currentPosition.z() - UNITOFFSET;

	for (float xf=MAPLOW; xf<MAPHIGH; xf+=CELL){
        for (float yf=MAPLOW; yf<MAPHIGH; yf+=CELL){
            if (tree_oct->search(xf, yf, zf)){
                octomap::OcTreeNode* key = tree_oct->search(xf, yf, zf);

				if(!(tree_oct->isNodeOccupied(key))){
					octomap::point3d point (xf, yf, zf);
					float distance = currentPosition.distance(point);

					if ((distance>MINDISTANCE) && (distance<MAXDISTANCE)){
						int xfN = (int) ((xf + OFFSET)*INVCELL);
						int yfN = (int) ((yf + OFFSET)*INVCELL);

						initialGrid[yfN][xfN] = 0;

						int xflow = xfN;
						int xfhigh = xfN+MASKSIDE;
						int yflow = yfN;
						int yfhigh = yfN+MASKSIDE;

						for (int af=xflow; af<xfhigh; af++){
							for (int bf=yflow; bf<yfhigh; bf++){
								paddedGrid[bf][af] = 0;
							}
						}
					}
				}
            }
        }
    }

	for (int i=0; i<ROW; i++){
		for (int j=0; j<COL; j++){
			processedGrid[i][j] = paddedGrid[i+MASKSIDE-1][j+MASKSIDE-1];
		}
	}
}

/*
/ converts the gridmaps into a 'gridMap' msgs, path into 'pointDataArray and publishes it
*/

void global_path_planner::processPath(std::vector<octomap::point3d> &inPath, std::vector<octomap::point3d> &outPath){
	outPath.clear();

	for (int i=0; i<inPath.size(); i++){

		float x = (float) inPath[i].x()*CELL;
		float y = (float) inPath[i].y()*CELL;
		float z = (float) inPath[i].z();

		octomap::point3d node (x, y, z);
		outPath.push_back(node);
	}
	
	inPath.clear();
}

void global_path_planner::saveOctomap(const std::string &filename){
	tree_oct->write(filename);
}