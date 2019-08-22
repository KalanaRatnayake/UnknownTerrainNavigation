#include <ros/ros.h>
#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>
#include <octomap/octomap.h>
#include <octomap/OcTree.h>
#include <nav_msgs/Odometry.h>
#include <nav_planner/pointData.h>
#include <nav_planner/pointDataArray.h>
#include <nav_planner/goalControl.h>
#include <goal_identifier.h>


std::vector<octomap::point3d> centerArray;
octomap::point3d goal;

goal_identifier identifierObject = goal_identifier(0.75f, 10.0f, 0.05, 10.0f, 10.0f, 10.0f, 0.02f);

/*  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap) and 'pose' at (nav_msgs/Odometry)
/   mapCallback and positionCallback handles incoming msgs from these two topics.  
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg)
{
    octomap::AbstractOcTree* tree = octomap_msgs::msgToMap(*msg);
    octomap::OcTree* tree_oct = dynamic_cast<octomap::OcTree*>(tree);
	identifierObject.update_tree(tree_oct);
}

void positionCallback(const nav_msgs::Odometry::ConstPtr &msg)
{
	octomap::point3d position = octomap::point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);
	identifierObject.update_position(position);
}


/*
/   calculation is done upon the server request on the (execute) and response is given as a (x,y,z) cooredinates
*/

bool executionCallback(nav_planner::goalControl::Request &request, nav_planner::goalControl::Response &response)
{
	if (request.execute){
		identifierObject.calculate(centerArray, goal);
	}

	response.x = goal.x();
	response.y = goal.y();
	response.z = goal.z();

	return true;
}


/*  goal and centerPointArray which are returned by identifierObject is published in (nav_planner/goal) topic and 
/   (nav_planner/centerArray). These utilize custom messages defined in 'msg' folder.
*/

int main(int argc, char **argv)
{
	ros::init (argc, argv, "Goal_Identifier");
	ros::NodeHandle node;

    ros::Subscriber octree_sub = node.subscribe("octomap", 1, mapCallback);
	ros::Subscriber odom_sub = node.subscribe("odometry", 1, positionCallback);

	ros::ServiceServer service = node.advertiseService("goalPosition", executionCallback);

	ros::Publisher centerArray_pub = node.advertise<nav_planner::pointDataArray>("centerArray", 1000);
	ros::Publisher centerPoint_pub = node.advertise<nav_planner::pointData>("goalPoint", 1);

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
	}

	ros::spin();
	return 0;
}

  
