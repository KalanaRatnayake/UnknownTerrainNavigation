#include <ros/ros.h>
#include <octomap_msgs/Octomap.h>
#include <octomap/octomap.h>
#include <nav_msgs/Odometry.h>
#include "nav_planner/pointData.h"
#include "nav_planner/pointDataArray.h"
#include "nav_planner/goalControl.h"
#include "nav_planner/goal_identifier/goal_identifier.h"


nav_planner::goal_identifier identifierObject = goal_identifier(0.75, 10, 0.05, 10, 10, 10);

/*  The node subscribe to topics 'Octomap' at (octomap_msgs/Octomap) and 'pose' at (nav_msgs/Odometry)
/   mapCallback and positionCallback handles incoming msgs from these two topics.  
*/

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg)
{
    octomap::OcTree* tree_oct = dynamic_cast<octomap::OcTree*>(octomap_msgs::msgToMap(*msg));
	identifierObject.update_tree(tree_oct);
}

void positionCallback(const nav_msgs::Odometry::ConstPtr &msg)
{
	octomap::Point3d position = octomap::Point3d(msg->pose.pose.position.x, msg->pose.pose.position.y, msg->pose.pose.position.z);
	identifierObject.update_position(position);
}


/*
/   calculation is done upon the server request on the (execute) and response is given as a (x,y,z) cooredinates
*/

void executionCallback(const nav_msgs::Odometry::ConstPtr &msg)
{
	identifierObject.calculate(tree_oct);
}


/*  goal and centerPointArray which are returned by identifierObject is published in (nav_planner/goal) topic and 
/   (nav_planner/centerArray). These utilize custom messages defined in 'msg' folder.
*/

int main(int argc, char **argv)
{
    ros::Subscriber octree_sub = n.subscribe<octomap_msgs::Octomap>("/octomap_binary", 1, boost::bind(&octomapCallback, _1, &planner_object));
	ros::Subscriber odom_sub = n.subscribe<nav_msgs::Odometry>("/bebop2/odometry_sensor1/odometry", 1, boost::bind(&odomCb, _1, &planner_object));
}

  
