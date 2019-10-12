#include "ros/ros.h"
#include <ros/console.h>
#include <nav_planner/systemControl.h>

int main(int argc, char **argv)
{
  ros::init(argc, argv, "test_system");
  ros::NodeHandle n;
  
  ROS_INFO("test_system_node : Initiated");

  ros::service::waitForService("System_Control");

  ros::ServiceClient client = n.serviceClient<nav_planner::systemControlRequest, nav_planner::systemControlResponse>("System_Control");
  
  ROS_INFO("test_system_node : client created");

  nav_planner::systemControl srv;

  srv.request.activate = true;
  
  ROS_INFO("test_system_node : requested");

  if (client.call(srv)){
    ROS_INFO("test_system_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service goalPosition");
    return 1;
  }

  return 0;
}
