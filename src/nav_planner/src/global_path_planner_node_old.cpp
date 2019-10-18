#include<bits/stdc++.h> 

#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <nav_msgs/Odometry.h>

#include <nav_planner/baseDrive.h>
#include <nav_planner/baseRotate.h>
#include <nav_planner/goalControl.h>
#include <nav_planner/goalRemove.h>
#include <nav_planner/systemControl.h>

//map
#define ROW 400 
#define COL 400

//map + 2*(padding) 
#define INITROW 408
#define INITCOL 408

//Map boundries
#define MAPLOW -0.2
#define MAPHIGH 20.2
#define offset 0.175
#define invcell 20  //multiply by 20 instead of dividing by cell size 0.05

//map + 4*(padding)
#define PADROW 416
#define PADCOL 416

//Robot description
#define HEIGHT 0.35


// Description of the Grid- {1--> not occupied} {0--> occupied} 

octomap::OcTree* tree_oct;
octomap::point3d currentPosition;

ros::ServiceClient clientGoalPosition;
ros::ServiceClient clientGoalRemove;
ros::ServiceClient forwardClient;
ros::ServiceClient rotateClient;

typedef std::pair<int, int> Pair; 
typedef std::pair<double, std::pair<int, int> > pPair; 

struct cell { 
	int parent_i, parent_j;
	double f, g, h; 
}; 

bool isValid(int row, int col) {
	return (row >= 0) && (row < ROW) && (col >= 0) && (col < COL); 
} 

bool isUnBlocked(int grid[][COL], int row, int col) { 
	if (grid[row][col] == 1) return (true); else return (false); 
}

bool isDestination(int row, int col, Pair dest) { 
	if (row == dest.first && col == dest.second) return (true); else return (false); 
} 

double calculateHValue(int row, int col, Pair dest) {
	return ((double) std::sqrt((row-dest.first)*(row-dest.first) + (col-dest.second)*(col-dest.second))); 
} 

void tracePath(cell cellDetails[][COL], Pair dest, std::vector<octomap::point3d> &outPath){
	int row = dest.first; 
	int col = dest.second; 

	std::stack<Pair> PathStack;
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
        octomap::point3d position = octomap::point3d(p.first, p.second, 0);
        path.push_back(position); 
	}
    outPath = path;
} 

bool aStarSearch(int grid[][COL], Pair src, Pair dest, std::vector<octomap::point3d> &outPath) {
	if (isValid (src.first, src.second) == false) return false;
	if (isValid (dest.first, dest.second) == false) return false;
	if (isUnBlocked(grid, src.first, src.second) == false || isUnBlocked(grid, dest.first, dest.second) == false) return false; 
	if (isDestination(src.first, src.second, dest) == true) return false; 

	bool closedList[ROW][COL]; 
	memset(closedList, false, sizeof (closedList)); 
	cell cellDetails[ROW][COL]; 
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

	std::set<pPair> openList; 
	openList.insert(std::make_pair (0.0, std::make_pair (i, j))); 
	bool foundDest = false; 

	while (!openList.empty()) { 
		pPair p = *openList.begin(); 
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

void buildMap(int (&outGrid)[INITROW][INITCOL]){
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

						int x = (int) (it.getX() + offset)*invcell;
						int y = (int) (it.getY() + offset)*invcell;
					
						outGrid[y][x] = 0;
					}
				} 
			}
		}
    }
}

void preprocessMap(int (&inGrid)[INITROW][INITCOL], int (&outGrid)[ROW][COL]){
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
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap), 'tf' at (tf/tfMessage). 
/  mapCallback and currentPositionCallback will handles incoming msgs from these two topics.
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg){
    octomap::AbstractOcTree* tree = octomap_msgs::msgToMap(*msg);
    tree_oct = dynamic_cast<octomap::OcTree*>(tree);
}

void currentPositionCallback(const nav_msgs::OdometryConstPtr &msg){
	currentPosition = octomap::point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);
}

bool systemCallback(nav_planner::systemControl::Request &request, nav_planner::systemControl::Response &response)
{
	while (ros::ok){
		nav_planner::goalControl srvGoal;
		nav_planner::goalRemove rmvGoal;
		nav_planner::baseDrive srvDrive;
		nav_planner::baseRotate srvRotate;

		octomap::point3d goal;
		octomap::point3d nextPosition;
		std::vector<octomap::point3d> path;

		int initialGrid [INITROW][INITCOL];
		int processedGrid [ROW][COL];
		int index =  0;
		bool pathFound;

		double distance;

		srvRotate.request.angle = 3.14;

		// rotate by 180 degrees
		if (rotateClient.call(srvRotate)){
			ROS_INFO("global_path_planner_node : first half rotated");
		} else {
			ROS_ERROR("global_path_planner_node : failed to call service baseRotate");
		}

		srvRotate.request.angle = 3.14;

		// rotate by 180 degrees
		if (rotateClient.call(srvRotate)){
			ROS_INFO("global_path_planner_node : second half rotated");
		} else {
			ROS_ERROR("global_path_planner_node : failed to call service baseRotate");
		}

		srvGoal.request.execute = true;

		ROS_INFO("global_path_planner_node : requested goalPosition service");

		if (clientGoalPosition.call(srvGoal)){
			ROS_INFO("global_path_planner_node : receieved goalPosition");
			goal = octomap::point3d(srvGoal.response.x, srvGoal.response.y, srvGoal.response.z);
		} else {
			ROS_ERROR("global_path_planner_A_node : failed to call service goalPosition");
		}

		buildMap(initialGrid);

		preprocessMap(initialGrid, processedGrid);

		pathFound = aStarSearch(processedGrid, std::make_pair(currentPosition.x(), currentPosition.y()), std::make_pair(goal.x(), goal.y()), path);

		while (!pathFound){
			rmvGoal.request.x = goal.x();
			rmvGoal.request.y = goal.y();
			rmvGoal.request.z = goal.z();

			if (clientGoalRemove.call(rmvGoal)){
				ROS_INFO("global_path_planner_node : removed goalPosition");
			}

			srvGoal.request.execute = true;

			ROS_INFO("global_path_planner_node : requested goalPosition service (recalculation)");

			if (clientGoalPosition.call(srvGoal)){
				ROS_INFO("global_path_planner_node : receieved goalPosition");

				goal = octomap::point3d(srvGoal.response.x, srvGoal.response.y, srvGoal.response.z);
			} else {
				ROS_ERROR("global_path_planner_A_node : failed to call service goalPosition");
			}

			pathFound = aStarSearch(processedGrid, std::make_pair(currentPosition.x(), currentPosition.y()), std::make_pair(goal.x(), goal.y()), path);
		}
		

		while ((distance <= 0.01) && pathFound) {

			nextPosition = path[index];
			index += 1;
			distance = goal.distance(currentPosition);

			srvDrive.request.x = nextPosition.x();
			srvDrive.request.y = nextPosition.y();
			srvDrive.request.z = nextPosition.z();

			ROS_INFO("global_path_planner_A_node : requested Control service");

			if (forwardClient.call(srvDrive)){
				ROS_INFO("global_path_planner_A_node : point reached");
			} else {
				ROS_ERROR("global_path_planner_A_node : failed to call service goalPosition");
			}
		}
	}
}

/*  
/    node starts itself and places server calls to both /goalPosition and /drive. goalPosition servercall starts the
/    goal calculation replies with goalPoint and drive servercall starts the movement of the robot and returns only after
/	 it reaches the currently specified point. it was implemented as this for maximum efficiency.
*/

int main(int argc, char **argv)
{
	ros::init (argc, argv, "global_path_planner_A");
	ros::NodeHandle node;
	
	ROS_INFO("Initialized the global_path_planner_A_node");

    ros::Subscriber map_sub = node.subscribe("octomap", 1, mapCallback);
	ros::Subscriber pos_sub = node.subscribe("position", 1, currentPositionCallback);
	
	ROS_INFO("global_path_planner_A_node : created subscribers");

	ros::service::waitForService("goalPosition");
	ros::service::waitForService("baseForword");
	ros::service::waitForService("baseRotate");

	clientGoalPosition = node.serviceClient<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition");
	clientGoalRemove = node.serviceClient<nav_planner::goalRemoveRequest, nav_planner::goalRemoveResponse>("goalRemove");
	forwardClient = node.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseForword");
    rotateClient = node.serviceClient<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate");
	
	ROS_INFO("global_path_planner_A_node : created service clients");

	ros::ServiceServer serviceCalculate = node.advertiseService<nav_planner::systemControlRequest, nav_planner::systemControlResponse>("System_Control", systemCallback);

	ros::AsyncSpinner spinner (5);
	ros::Rate r(100);

	spinner.start();
	
	ros::waitForShutdown();
	return 0;
}

  
