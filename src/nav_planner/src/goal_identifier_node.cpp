#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <nav_msgs/Odometry.h>

#include <nav_planner/pointData.h>
#include <nav_planner/pointDataArray.h>
#include <nav_planner/goalControl.h>
#include <nav_planner/goalRemove.h>

#include <memory>

#include <goal_identifier.h>


std::vector<octomap::point3d> centerArray;
octomap::point3d goal;

goal_identifier identifierObject = goal_identifier(0.5, 5.0, 0.05, 5.0, 5.0, 0.75, 0.95);

/*
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap) and 'pose' at (nav_msgs/Odometry)
/   mapCallback and positionCallback handles incoming msgs from these two topics.  
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg)
{
	std::shared_ptr<octomap::OcTree> tree = std::shared_ptr<octomap::OcTree> (dynamic_cast<octomap::OcTree*> (octomap_msgs::msgToMap(*msg)));
	identifierObject.update_tree(tree);
	
}

void currentPositionCallback(const nav_msgs::OdometryConstPtr &msg)
{
	octomap::point3d position = octomap::point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);
	identifierObject.update_position(position);
}


/*
/   calculation is done upon the server request on the (execute) and response is given as a (x,y,z) cooredinates
*/

bool executionCallback(nav_planner::goalControl::Request &request, nav_planner::goalControl::Response &response)
{ 
	bool completed;

	ROS_INFO("goal_identifier_node : request received");

	if (request.execute) identifierObject.calculate(centerArray, goal, completed);

	response.x = goal.x();
	response.y = goal.y();
	response.z = goal.z();
	response.isNull = completed;

	ROS_INFO("goal_identifier_node : response sent");

	return true;
}

bool removeCallback(nav_planner::goalRemove::Request &request, nav_planner::goalRemove::Response &response)
{
	ROS_INFO("goal_identifier_node : remove request received");

	octomap::point3d point(request.x, request.y, request.z);

	identifierObject.remove(point);

	response.success = true;

	ROS_INFO("goal_identifier_node : response sent");

	return true;
}


/*  goal and centerPointArray which are returned by identifierObject is published in (nav_planner/goal) topic and 
/   (nav_planner/centerArray). These utilize custom messages defined in 'msg' folder.
*/

int main(int argc, char **argv)
{
	ros::init (argc, argv, "Goal_Identifier");
	ros::NodeHandle node;
	
	ROS_INFO("Initialized the goal_identifier_node");

    ros::Subscriber octree_sub = node.subscribe("octomap", 1, mapCallback);
	ros::Subscriber positi_sub = node.subscribe("position", 1, currentPositionCallback);
	
	ROS_INFO("goal_identifier_node : created subscribers");

	ros::ServiceServer serviceFind = node.advertiseService<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition", executionCallback);
	ros::ServiceServer serviceRemo = node.advertiseService<nav_planner::goalRemoveRequest, nav_planner::goalRemoveResponse>("goalRemove", removeCallback);
	
	ROS_INFO("goal_identifier_node : created service");

	ros::Publisher centerArray_pub = node.advertise<nav_planner::pointDataArray>("centerArray", 1, true);
	ros::Publisher centerPoint_pub = node.advertise<nav_planner::pointData>("goalPoint", 1, true);
	
	ROS_INFO("goal_identifier_node : created publishers");

	while(ros::ok()){
		nav_planner::pointDataArray valueArray;
		nav_planner::pointData goalMsg;

		for(int i=1; i<centerArray.size(); i++){
			nav_planner::pointData msgInstance;

			msgInstance.x = centerArray[i].x();
			msgInstance.y = centerArray[i].y();
			msgInstance.z = centerArray[i].z();

			valueArray.centerPointsArray.push_back(msgInstance);
		}

		centerArray_pub.publish(valueArray);

		goalMsg.x = goal.x();
		goalMsg.y = goal.y();
		goalMsg.z = goal.z();

		centerPoint_pub.publish(goalMsg);

		ros::getGlobalCallbackQueue()->callAvailable(ros::WallDuration(0.01));
	}
	return 0;
}

  
