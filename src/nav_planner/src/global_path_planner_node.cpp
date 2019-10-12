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
#include <nav_planner/systemControl.h>

#include <global_path_planner.h>

ros::ServiceClient clientGoalPosition;
ros::ServiceClient forwardClient;
ros::ServiceClient rotateClient;

global_path_planner plannerObject = global_path_planner(0.45, 9, 9, 0.05f);

/*
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap), 'tf' at (tf/tfMessage). 
/  mapCallback and currentPositionCallback will handles incoming msgs from these two topics.
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg){
    octomap::AbstractOcTree* tree = octomap_msgs::msgToMap(*msg);
    octomap::OcTree* tree_oct = dynamic_cast<octomap::OcTree*>(tree);
	plannerObject.updateTree(tree_oct);
}

void currentPositionCallback(const nav_msgs::OdometryConstPtr &msg)
{
	octomap::point3d position = octomap::point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);
	plannerObject.updateCurrentPoint(position);
}

bool systemCallback(nav_planner::systemControl::Request &request, nav_planner::systemControl::Response &response)
{
	while (ros::ok){
		nav_planner::goalControl srvGoal;
		nav_planner::baseDrive srvDrive;
		nav_planner::baseRotate srvRotate;

		octomap::point3d goal;
		octomap::point3d nextPosition;

		double distance;

		srvRotate.request.angle = 3.14;

		// rotate by 180 degrees
		if (forwardClient.call(srvRotate)){
			ROS_INFO("global_path_planner_node : first half rotated");
		} else {
			ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
		}

		srvRotate.request.angle = 3.14;

		// rotate by 180 degrees
		if (forwardClient.call(srvRotate)){
			ROS_INFO("global_path_planner_node : second half rotated");
		} else {
			ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
		}

		srvGoal.request.execute = true;

		ROS_INFO("global_path_planner_node : requested goalPosition service");

		if (clientGoalPosition.call(srvGoal)){
			ROS_INFO("global_path_planner_node : receieved goalPosition");

			goal = octomap::point3d(srvGoal.response.x, srvGoal.response.y, srvGoal.response.z);
			plannerObject.updateGoalPoint(goal);

		} else {
			ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
		}

		do{
			plannerObject.getNextPosition(nextPosition);
			distance = goal.distance(nextPosition);

			srvDrive.request.x = nextPosition.x();
			srvDrive.request.y = nextPosition.y();
			srvDrive.request.z = nextPosition.z();

			ROS_INFO("global_path_planner_node : requested Control service");

			if (forwardClient.call(srvDrive)){
				ROS_INFO("global_path_planner_node : point reached");
			} else {
				ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
			}
		} while (distance >= 0.01);
	}
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

    ros::Subscriber map_sub = node.subscribe("octomap", 1, mapCallback);
	ros::Subscriber pos_sub = node.subscribe("position", 1, currentPositionCallback);
	
	ROS_INFO("global_path_planner_node : created subscribers");

	ros::service::waitForService("goalPosition");
	ros::service::waitForService("baseForword");
	ros::service::waitForService("baseRotate");

	clientGoalPosition = node.serviceClient<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition");
	forwardClient = node.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseForword");
    rotateClient = node.serviceClient<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate");
	
	ROS_INFO("global_path_planner_node : created service clients");

	ros::ServiceServer serviceCalculate = node.advertiseService<nav_planner::systemControlRequest, nav_planner::systemControlResponse>("System_Control", systemCallback);

	ros::AsyncSpinner spinner (5);
	ros::Rate r(100);

	spinner.start();
	
	ros::waitForShutdown();
	return 0;
}

  
