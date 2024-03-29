#include "ros/ros.h"
#include <ros/console.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <nav_planner/baseDrive.h>
#include <nav_planner/baseRotate.h>

#include <cstdlib>

int main(int argc, char **argv)
{
  ros::init(argc, argv, "test_velocityControl_node");
  ros::NodeHandle n;
  
  ROS_INFO("test_velocityControl_node : Initiated");
  
	ros::service::waitForService("baseForword");
	ros::service::waitForService("baseRotate");

  ros::ServiceClient forwardClient = n.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseForword");
  ros::ServiceClient reverseClient = n.serviceClient<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseReverse");
  ros::ServiceClient rotateClient = n.serviceClient<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate");
  
  ROS_INFO("test_velocityControl_node : client created");

  nav_planner::baseDrive forward;
  nav_planner::baseRotate rotate;

  forward.request.x = 2.0;
  forward.request.y = 0.0;
  forward.request.z = 0.0;
  
  ROS_INFO("test_velocityControl_node : forward requested");

  if (forwardClient.call(forward)){
    ROS_INFO("test_velocityControl_node : response recieved");
    if (forward.response.success) {
      ROS_INFO("test_velocityControl_node : reached successfully");
    } else {
      ROS_INFO("test_velocityControl_node : failed to reach");
    }
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  forward.request.x = 2.0;
  forward.request.y = 0.0;
  forward.request.z = 0.0;
  
  ROS_INFO("test_velocityControl_node : forward requested");

  if (reverseClient.call(forward)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  rotate.request.angle = 1.57;
  
  ROS_INFO("test_velocityControl_node : rotate requested");

  if (rotateClient.call(rotate)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  forward.request.x = 1.0;
  forward.request.y = 2.0;
  forward.request.z = 0.0;
  
  ROS_INFO("test_velocityControl_node : forward requested");

  if (forwardClient.call(forward)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  rotate.request.angle = 3.141;
  
  ROS_INFO("test_velocityControl_node : rotate requested");

  if (rotateClient.call(rotate)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  forward.request.x = 0.0;
  forward.request.y = 0.0;
  forward.request.z = 0.0;
  
  ROS_INFO("test_velocityControl_node : forward requested");

  if (forwardClient.call(forward)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  rotate.request.angle = 3.141;
  
  ROS_INFO("test_velocityControl_node : rotate requested");

  if (rotateClient.call(rotate)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  rotate.request.angle = 3.141;
  
  ROS_INFO("test_velocityControl_node : rotate requested");

  if (rotateClient.call(rotate)){
    ROS_INFO("test_velocityControl_node : response recieved");
    
  } else {
    ROS_ERROR("Failed to call service baseForward");
    return 1;
  }

  return 0;
}
