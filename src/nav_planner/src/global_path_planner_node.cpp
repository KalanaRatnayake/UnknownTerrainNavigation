#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <nav_msgs/Odometry.h>

#include <nav_planner/gridRow.h>
#include <nav_planner/gridMap.h>
#include <nav_planner/gridPoint.h>

#include <nav_planner/baseDrive.h>
#include <nav_planner/baseRotate.h>
#include <nav_planner/goalControl.h>
#include <nav_planner/goalRemove.h>
#include <nav_planner/systemControl.h>

#include <global_path_planner.h>

//map
#define ROW 400 
#define COL 400

//map + 2*(padding) 
#define INITROW 408
#define INITCOL 408
#define PADDING 4

#define CLEARENCE_DISTANCE 2

// Description of the Grid- {1--> not occupied} {0--> occupied} 

global_path_planner plannerObject = global_path_planner(); 

octomap::point3d currentPosition;
octomap::point3d goal;
octomap::point3d nextPosition;
octomap::point3d markedPosition;
std::vector<octomap::point3d> path;

ros::ServiceClient clientGoalPosition;
ros::ServiceClient clientGoalRemove;
ros::ServiceClient forwardClient;
ros::ServiceClient rotateClient;

ros::Publisher grid_pub;

ros::Subscriber map_sub;
ros::Subscriber pos_sub;

bool unExplored = true;

/*
/ once the map is completely explored, this function will be called to save the octomap and execute ros::shutdown()
*/

void exit(){
	unExplored = false;
}

/*
/ request rotateBase service to make the robot rotate inplace
*/

void rotate360(){
	nav_planner::baseRotate srvRotate;

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
}

/*
/ request the goalPosition service to get a new goal
*/

void requestGoal(){
	nav_planner::goalControl srvGoal;

	srvGoal.request.execute = true;

	ROS_INFO("global_path_planner_node : requested goalPosition service");

	if (clientGoalPosition.call(srvGoal)){
		ROS_INFO("global_path_planner_node : receieved goalPosition");

		goal = octomap::point3d(srvGoal.response.x, srvGoal.response.y, srvGoal.response.z);
		
		if (srvGoal.response.isNull){
			exit();
		}

	} else {
		ROS_ERROR("global_path_planners_node : failed to call service goalPosition");
	}

	plannerObject.update_goal(goal);
}

/*
/ removes goal if the goal cannot be reached or a path to goal cannot be calculated
*/

void removeGoal(){
	nav_planner::goalRemove rmvGoal;

	rmvGoal.request.x = goal.x();
	rmvGoal.request.y = goal.y();
	rmvGoal.request.z = goal.z();

	if (clientGoalRemove.call(rmvGoal)){
		ROS_INFO("global_path_planner_node : removed goalPosition");
	}
}

/*
/ message to drive the robot from currentPosition to nextPosition
*/

void drive(){
	nav_planner::baseDrive srvDrive;

	srvDrive.request.x = nextPosition.x();
	srvDrive.request.y = nextPosition.y();
	srvDrive.request.z = nextPosition.z();

	ROS_INFO("global_path_planner_node : requested Control service");

	if (forwardClient.call(srvDrive)){
		ROS_INFO("global_path_planner_node : point reached");
	} else {
		ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
	}
}

/*
/ converts the gridmaps into a 'gridMap' msgs, path into 'pointDataArray and publishes it
*/

void publish(int (&initGrid)[INITROW][INITCOL], int (&procGrid)[ROW][COL], std::vector<octomap::point3d> path){
	nav_planner::gridMap map;

	for (int i=0; i<ROW; i++){
		nav_planner::gridRow rowArray;

		for(int j=0; j<COL; j++) {
			nav_planner::gridPoint point;
			
			point.init = initGrid[i+4][j+4];
			point.proc = procGrid[i][j];

			for (int k=0; k<path.size(); k++){
				if ((i==path[k].y())&&(j==path[k].x())) point.path = 0; else point.path = 1;
			}

			rowArray.row.push_back(point);
		}
		map.grid.push_back(rowArray);
	}

	grid_pub.publish(map);
}

/*
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap), 'tf' at (tf/tfMessage). 
/  mapCallback and currentPositionCallback will handles incoming msgs from these two topics.
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg){
    octomap::AbstractOcTree* tree = octomap_msgs::msgToMap(*msg);
    octomap::OcTree* tree_oct = dynamic_cast<octomap::OcTree*>(tree);
	plannerObject.update_tree(tree_oct);
}

void currentPositionCallback(const nav_msgs::OdometryConstPtr &msg){
	currentPosition = octomap::point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);
	plannerObject.update_position(currentPosition);
}

bool systemCallback(nav_planner::systemControl::Request &request, nav_planner::systemControl::Response &response){
	while (unExplored && request.activate){
		int initialGrid [INITROW][INITCOL];
		int processedGrid [ROW][COL];
		int index =  0;
		bool pathFound;
		double remainingDistance, gapDistance = 0;

		rotate360();
		requestGoal();
		plannerObject.buildMap(initialGrid);
		plannerObject.preprocessMap(initialGrid, processedGrid);

		pathFound = plannerObject.search(processedGrid, std::make_pair(currentPosition.y(), currentPosition.x()), std::make_pair(goal.y(), goal.x()), path);

		while (!pathFound){
			removeGoal();
			requestGoal();
			pathFound = plannerObject.search(processedGrid, std::make_pair(currentPosition.y(), currentPosition.x()), std::make_pair(goal.y(), goal.x()), path);
		}
		
		markedPosition = currentPosition;
		plannerObject.cleanPath(path);

		publish(initialGrid, processedGrid, path);

		while ((remainingDistance <= 0.01) && pathFound) {
			nextPosition = path[index];
			gapDistance = markedPosition.distance(nextPosition);
			drive();
			if (gapDistance < CLEARENCE_DISTANCE) index++; else break;
			remainingDistance = goal.distance(currentPosition);
		}
	}

	response.success = true;
	ros::shutdown();
}

/*  
/    node starts itself and places server calls to both /goalPosition and /drive. goalPosition servercall starts the
/    goal calculation replies with goalPoint and drive servercall starts the movement of the robot and returns only after
/	 it reaches the currently specified point. it was implemented as this for maximum efficiency.
*/

int main(int argc, char **argv)
{
	ros::init (argc, argv, "Global_Path_Planner");
	ros::NodeHandle node;
	
	ROS_INFO("Initialized the global_path_planner_node");

    map_sub = node.subscribe("octomap", 1, mapCallback);
	pos_sub = node.subscribe("position", 1, currentPositionCallback);
	
	ROS_INFO("global_path_planner_node : created subscribers");

	grid_pub = node.advertise<nav_planner::gridMap>("grid", 1, true);
	
	ROS_INFO("global_path_planner_node : created publishers");

	ros::service::waitForService("goalPosition");
	ros::service::waitForService("goalRemove");
	ros::service::waitForService("baseForword");
	ros::service::waitForService("baseRotate");

	clientGoalPosition = node.serviceClient<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition");
	clientGoalRemove = node.serviceClient<nav_planner::goalRemoveRequest, nav_planner::goalRemoveResponse>("goalRemove");
	forwardClient = node.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseForword");
    rotateClient = node.serviceClient<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate");
	
	ROS_INFO("global_path_planner_node : created service clients");

	ros::ServiceServer serviceCalculate = node.advertiseService<nav_planner::systemControlRequest, nav_planner::systemControlResponse>("explore", systemCallback);

	ros::AsyncSpinner spinner (5);
	ros::Rate r(100);

	spinner.start();
	
	ros::waitForShutdown();
	return 0;
}

  
