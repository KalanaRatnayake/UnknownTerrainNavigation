#include "ros/ros.h"
#include <ros/console.h>

#include <nav_planner/baseDrive.h>
#include <nav_planner/baseRotate.h>

#include <cstdlib>

int main(int argc, char **argv)
{
  ros::init(argc, argv, "test_velocityControl_node");
  ros::NodeHandle n;
  
  ROS_INFO("test_velocityControl_node : Initiated");

  ros::ServiceClient forward = n.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseForword");
  ros::ServiceClient rotate = n.serviceClient<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate");
  
  ROS_INFO("test_velocityControl_node : client created");

  nav_planner::baseDrive forward;
  nav_planner::baseRotate rotate;

  forward.request.x = 2.0;
  forward.request.y = 0.0;
  forward.request.z = 0.0;
  
  ROS_INFO("test_velocityControl_node : forward requested");

  if (client.call(forward)){
    ROS_INFO("x : %b", forward.response.success);
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  rotate.request.execute = true;
  
  ROS_INFO("test_velocityControl_node : rotate requested");

  if (client.call(rotate)){
    ROS_INFO("x : %b", rotate.response.success);
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  forward.request.x = 2.0;
  forward.request.y = 1.0;
  forward.request.z = 0.0;
  
  ROS_INFO("test_velocityControl_node : forward requested");

  if (client.call(forward)){
    ROS_INFO("x : %b", forward.response.success);
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  return 0;
}
