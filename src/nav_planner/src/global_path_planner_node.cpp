#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <tf2/LinearMath/Quaternion.h>
#include <tf2/LinearMath/Matrix3x3.h>

#include <nav_msgs/Odometry.h>

#include <nav_planner/gridRow.h>
#include <nav_planner/gridMap.h>
#include <nav_planner/gridPoint.h>
#include <nav_planner/pointData.h>

#include <nav_planner/baseDrive.h>
#include <nav_planner/baseRotate.h>
#include <nav_planner/goalControl.h>
#include <nav_planner/goalRemove.h>
#include <nav_planner/systemControl.h>

#include <memory>

#include <global_path_planner.h>

//map
#define ROW 400 
#define COL 400

//map + 2*(padding) 
#define INITROW 408
#define INITCOL 408

#define PADDING 4
#define OFFSET 0.175
#define CELL (float)0.05
#define INVCELL 20  //multiply by 40 instead of dividing by cell size 0.025
#define UNITOFFSET 0.025

#define CLEARENCE_DISTANCE 2.5
#define CLEARENCE_ANGLE 1.05

// Description of the Grid- {1--> not occupied} {0--> occupied} 

global_path_planner plannerObject = global_path_planner(); 

octomap::point3d currentPosition;
octomap::point3d goal;
octomap::point3d nextPosition;
octomap::point3d previousPosition;

ros::ServiceClient clientGoalPosition;
ros::ServiceClient clientGoalRemove;
ros::ServiceClient forwardClient;
ros::ServiceClient reverseClient;
ros::ServiceClient rotateClient;

ros::Publisher grid_pub;

ros::Subscriber map_sub;
ros::Subscriber pos_sub;

bool unExplored = true;

double Roll, Pitch, Yaw;
double currentYaw;

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

bool drive(octomap::point3d &nextPosition){
	nav_planner::baseDrive srvDrive;

	srvDrive.request.x = nextPosition.x();
	srvDrive.request.y = nextPosition.y();
	srvDrive.request.z = nextPosition.z();

	ROS_INFO("global_path_planner_node : requested Control service");

	if (forwardClient.call(srvDrive)){
		ROS_INFO("global_path_planner_node : point reached");
		if (srvDrive.response.success){
			return true;
		} else {
			return false;
		}
	} else {
		ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
		return false;
	}
}

void reverse(octomap::point3d &nextPosition){
	nav_planner::baseDrive srvDrive;

	srvDrive.request.x = nextPosition.x();
	srvDrive.request.y = nextPosition.y();
	srvDrive.request.z = nextPosition.z();

	ROS_INFO("global_path_planner_node : requested Control service");

	if (reverseClient.call(srvDrive)){
		ROS_INFO("global_path_planner_node : reversed");
	} else {
		ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
	}
}

/*
/ converts the gridmaps into a 'gridMap' msgs, path into 'pointDataArray and publishes it
*/

void publish(std::vector<std::vector<int> > &initGrid, std::vector<std::vector<int> > &procGrid, std::vector<octomap::point3d> &path){
	nav_planner::gridMap gridMap;

	for (int i=0; i<ROW; i++){
		nav_planner::gridRow rowArray;

		for(int j=0; j<COL; j++) {
			nav_planner::gridPoint point;
			
			point.init = initGrid[i+PADDING][j+PADDING];
			point.proc = procGrid[i][j];

			rowArray.row.push_back(point);
		}
		gridMap.grid.push_back(rowArray);
	}

	for(int i=0; i<path.size(); i++){
		nav_planner::pointData msgInstance;

		msgInstance.x = path[i].x();
		msgInstance.y = path[i].y();
		msgInstance.z = 0;

		gridMap.path.push_back(msgInstance);
	}

	gridMap.pathLength = path.size();
	
	grid_pub.publish(gridMap);
}

/*
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap), 'tf' at (tf/tfMessage). 
/  mapCallback and currentPositionCallback will handles incoming msgs from these two topics.
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg){
	std::shared_ptr<octomap::OcTree> tree = std::shared_ptr<octomap::OcTree> (dynamic_cast<octomap::OcTree*> (octomap_msgs::msgToMap(*msg)));
	plannerObject.update_tree(tree);
}

void currentPositionCallback(const nav_msgs::OdometryConstPtr &msg){
	currentPosition = octomap::point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);

	tf2::Quaternion q(msg->pose.pose.orientation.x, msg->pose.pose.orientation.y, msg->pose.pose.orientation.z, msg->pose.pose.orientation.w);
	tf2::Matrix3x3 m(q);

	m.getRPY(Roll, Pitch, Yaw);

	if ((Yaw<3.14)&&(Yaw>-3.14)){
		currentYaw = Yaw;
	}

	plannerObject.update_position(currentPosition);
}

bool systemCallback(nav_planner::systemControl::Request &request, nav_planner::systemControl::Response &response){
	// Description of the Grid- {1--> not occupied} {0--> occupied}

	while (unExplored && request.activate){
		std::vector<std::vector<int> > initialGrid( INITROW, std::vector<int> (INITCOL, 1));
		std::vector<std::vector<int> > processedGrid( ROW, std::vector<int> (COL, 1));

		int index =  1;
		bool pathFound;
		double remainingDistance, travelledDistance = 0;
		double desiredYaw, angle;
		std::vector<octomap::point3d> path, processedPath;

		//rotate and update the octomap
		rotate360();

		//calculate new goal
		requestGoal();

		//build the map for the path calculation
		plannerObject.buildMap(initialGrid, processedGrid);

		//turn source and goal into points on the grid
		int srcX = (int) (currentPosition.x()*INVCELL);
		int srcY = (int) (currentPosition.y()*INVCELL);

		int desX = (int) (goal.x()*INVCELL);
		int desY = (int) (goal.y()*INVCELL);

		//calculate path
		pathFound = plannerObject.search(processedGrid, std::make_pair(srcY, srcX), std::make_pair(desY, desX), path);

		//iterate till a path is found
		while (!pathFound){

			//remove goal if path is not found
			removeGoal();

			//rerequest the goal
			requestGoal();
			
			//turn source and goal into points on the grid
			int srcX = (int) (currentPosition.x()*INVCELL);
			int srcY = (int) (currentPosition.y()*INVCELL);

			int desX = (int) (goal.x()*INVCELL);
			int desY = (int) (goal.y()*INVCELL);

			//calculate new path
			pathFound = plannerObject.search(processedGrid, std::make_pair(srcY, srcX), std::make_pair(desY, desX), path);
		}

		//publish the calculated grid and path
		publish(initialGrid, processedGrid, path);

		//convert grid path into realworld path
		plannerObject.processPath(path, processedPath);

		//calculate distance to the goal and mark current position as previous position
		remainingDistance = goal.distance(currentPosition);
		previousPosition = currentPosition;
		
		while ((remainingDistance >= 0.1) && pathFound) {
			//update position to be reached
			nextPosition = processedPath[index];
			
			//check whether a large turn is needed. if so recalculation is needed. so exit loop
			desiredYaw = atan2(nextPosition.y()-currentPosition.y(), nextPosition.x()-currentPosition.x());
			angle = std::abs(desiredYaw - currentYaw);

			//check travelled distance and update previous position
			travelledDistance += previousPosition.distance(nextPosition);

			//if return false if collided, else true
			if (!(drive(nextPosition))) {
				reverse(nextPosition);
				break;
			};

			if ((angle>CLEARENCE_ANGLE)&&(index!=1)) break;

			//exit loop of travelledDistance is over the limit. if not, continue
			if (travelledDistance > CLEARENCE_DISTANCE) break;
				
			//calculate remaining distance
			previousPosition = currentPosition;
			remainingDistance = goal.distance(currentPosition);
			index++;		
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
	reverseClient = node.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseReverse");
    rotateClient = node.serviceClient<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate");
	
	ROS_INFO("global_path_planner_node : created service clients");

	ros::ServiceServer serviceCalculate = node.advertiseService<nav_planner::systemControlRequest, nav_planner::systemControlResponse>("explore", systemCallback);

	ros::AsyncSpinner spinner (5);
	ros::Rate r(100);

	spinner.start();
	
	ros::waitForShutdown();
	return 0;
}

  
