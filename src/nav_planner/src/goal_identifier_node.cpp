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

#include <goal_identifier.h>


std::vector<octomap::point3d> centerArray;
octomap::point3d goal;

goal_identifier identifierObject = goal_identifier(0.50, 10.0, 0.05, 20.0, 20.0, 3.0, 0.95);

/*
/  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap) and 'pose' at (nav_msgs/Odometry)
/   mapCallback and positionCallback handles incoming msgs from these two topics.  
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg)
{
    octomap::AbstractOcTree* tree = octomap_msgs::msgToMap(*msg);
    octomap::OcTree* tree_oct = dynamic_cast<octomap::OcTree*>(tree);
	identifierObject.update_tree(tree_oct);
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
	ROS_INFO("goal_identifier_node : request received");

	if (request.execute){
		identifierObject.calculate(centerArray, goal);
	}

	response.x = goal.x();
	response.y = goal.y();
	response.z = goal.z();

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

	ros::ServiceServer service = node.advertiseService<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition", executionCallback);
	
	ROS_INFO("goal_identifier_node : created service");

	ros::Publisher centerArray_pub = node.advertise<nav_planner::pointDataArray>("centerArray", 1, true);
	ros::Publisher centerPoint_pub = node.advertise<nav_planner::pointData>("goalPoint", 1, true);
	
	ROS_INFO("goal_identifier_node : created publishers");

	while(ros::ok()){
		int lenM = centerArray.size();
		nav_planner::pointDataArray valueArray;
		nav_planner::pointData goalMsg;

		for(int i=1; i<lenM; i++){
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

  
