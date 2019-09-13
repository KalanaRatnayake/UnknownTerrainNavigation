#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <tf/tfMessage.h>
#include <geometry_msgs/TransformStamped.h>
#include <geometry_msgs/Transform.h>
#include <geometry_msgs/Vector3.h>

#include <nav_planner/goalControl.h>
#include <nav_planner/baseDrive.h>

#include <global_path_planner.h>

bool robotMask [9][9]= {
            {false, false,  true,  true,  true,  true,  true, false, false},
            {false,  true,  true,  true,  true,  true,  true,  true, false},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            {false,  true,  true,  true,  true,  true,  true,  true, false},
            {false, false,  true,  true,  true,  true,  true, false, false},
};

global_path_planner plannerObject = global_path_planner(0.45, 9, 9, 0.05f, robotMask);

/*
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap), 'tf' at (tf/tfMessage). 
/  mapCallback and currentPositionCallback will handles incoming msgs from these two topics.
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg){
    octomap::AbstractOcTree* tree = octomap_msgs::msgToMap(*msg);
    octomap::OcTree* tree_oct = dynamic_cast<octomap::OcTree*>(tree);
	plannerObject.updateTree(tree_oct);
}

void currentPositionCallback(const tf::tfMessage::ConstPtr &msg)
{
	octomap::point3d position = octomap::point3d(msg->transforms[0].transform.translation.x, msg->transforms[0].transform.translation.y, msg->transforms[0].transform.translation.z);
	plannerObject.updateCurrentPoint(position);
}

/*  
/    node starts itself and places server calls to both /goalPosition and /drive. goalPosition servercall starts the
/    goal calculation replies with goalPoint and drive servercall starts the movement of the robot and returns only after
/	 it reaches the currently specified point. it was implemented as this for maximum efficiency.
*/

int main(int argc, char **argv)
{
	ros::init (argc, argv, "Global_path_planner");
	ros::NodeHandle node;
	
	ROS_INFO("Initialized the global_path_planner_node");

    ros::Subscriber tree_sub = node.subscribe("octomap", 10, mapCallback);
	ros::Subscriber posi_sub = node.subscribe("position", 10, currentPositionCallback);
	
	ROS_INFO("global_path_planner_node : created subscribers");

	ros::ServiceClient clientGoalPosition = n.serviceClient<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition");
	ros::ServiceClient clientBaseDrive = n.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseControl");
	
	ROS_INFO("global_path_planner_node : created service clients");

	while(ros::ok()){
		nav_planner::goalControl srvGoal;
		nav_planner::goalControl srvDrive;
		octomap::point3d goal;
		octomap::point3d nextPosition;
		double distance;

		srvGoal.request.execute = true;

		ROS_INFO("global_path_planner_node : requested goalPosition service");

		if (clientGoalPosition.call(srvGoal)){
			ROS_INFO("global_path_planner_node : requested goalPosition service");

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

			if (clientBaseDrive.call(srvDrive)){
				ROS_INFO("global_path_planner_node : requested Control service");
			} else {
				ROS_ERROR("global_path_planner_node : failed to call service goalPosition");
			}

		} while (distance >= 0.01);

		ros::getGlobalCallbackQueue()->callAvailable(ros::WallDuration(0.01));
	}
	return 0;
}

  
