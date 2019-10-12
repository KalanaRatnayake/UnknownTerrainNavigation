#include "ros/ros.h"
#include <ros/console.h>
#include <nav_planner/goalControl.h>
#include <cstdlib>

int main(int argc, char **argv)
{
  ros::init(argc, argv, "test_goalPositionClient_node");
  ros::NodeHandle n;
  
  ROS_INFO("test_goalPositionClient_node : Initiated");

  ros::service::waitForService("goalPosition");

  ros::ServiceClient client = n.serviceClient<nav_planner::goalControlRequest, nav_planner::goalControlResponse>("goalPosition");
  
  ROS_INFO("test_goalPositionClient_node : client created");

  nav_planner::goalControl srv;

  srv.request.execute = true;
  
  ROS_INFO("test_goalPositionClient_node : requested");

  if (client.call(srv)){
    ROS_INFO("x : %f", srv.response.x);
    ROS_INFO("y : %f", srv.response.y);
    ROS_INFO("z : %f", srv.response.z);
    ROS_INFO("test_goalPositionClient_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service goalPosition");
    return 1;
  }

  return 0;
}
