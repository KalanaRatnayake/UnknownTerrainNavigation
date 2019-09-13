#include <cmath>

#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <ecl/time.hpp>
#include <ecl/exceptions.hpp>

#include <tf/tfMessage.h>
#include <geometry_msgs/TransformStamped.h>
#include <geometry_msgs/Transform.h>
#include <geometry_msgs/Vector3.h>

#include <geometry_msgs/Twist.h>
#include <kobuki_msgs/MotorPower.h>

#include <nav_planner/baseDrive.h>

octomap::point3d currentPosition;
cotomap::point3d goalPosition;
geometry_msgs::TwistPtr* cmd;

bool power_status = false;
bool connected = false;

ecl::MilliSleep millisleep;
int count = 0;

double linear_vel_max, vel_constant;
double angular_vel_max, ang_constant;
double currentRoll, currentPitch, currentYaw;
double pi = 3.14159265;


void currentPositionCallback(const tf::tfMessage::ConstPtr &msg)
{
	octomap::point3d position = octomap::point3d(msg->transforms[0].transform.translation.x, msg->transforms[0].transform.translation.y, msg->transforms[0].transform.translation.z);
    
	tf::Quaternion q(msg->transforms[0].transform.rotation.x, msg->transforms[0].transform.rotation.y, msg->transforms[0].transform.rotation.z, msg->transforms[0].transform.rotation.w);
	tf::Matrix3x3 m(q);

	m.getRPY(currentRoll, currentPitch, currentYaw);
	currentPosition = position;
}

bool executionCallback(nav_planner::baseDrive::Request &request, nav_planner::baseDrive::Response &response)
{ 
	ROS_INFO("velocity_control_node : request received");

    goalPosition.x() = request.x;
	goalPosition.y() = request.y;
	goalPosition.z() = request.z;

	if (!power_status){
		ROS_INFO("velocity_control_node : motor was powered down. turning on now....");
		kobuki_msgs::MotorPower power_cmd;
		power_cmd.state = kobuki_msgs::MotorPower::ON;
		motpower_pub.publish(power_cmd);
		ROS_INFO("velocity_control_node : successfully powered up.");
		power_status = true;
	}

	do{
		double desiredYaw = atan2(goalPosition.y()-currentPosition.y(), goalPosition.x()-currentPosition.x())+(pi*0.5);
		double angleDiff = desiredYaw - currentYaw;
		double angularV = ang_constant*angleDiff;

		if (angularV >= angular_vel_max) cmd->angular.z = angular_vel_max; else cmd->angular.z = angularV;
		velocity_pub.publish(cmd);
	} while (angleDiff>=0.01);

	cmd->angular.z = 0;

	do{
		double distance = goalPosition.distance(currentPosition);
		double velocity = distance*vel_constant;

		if (velocity >= linear_vel_max) cmd->linear.x = linear_vel_max; else cmd->linear.x = velocity;
		velocity_pub.publish(cmd);
	} while (distance>=0.01);

	cmd->linear.x = 0;
	double desiredYaw = currentYaw + pi;

	do{
		double angleDiff = desiredYaw - currentYaw;
		double angularV = ang_constant*angleDiff;

		if (angularV >= angular_vel_max) cmd->angular.z = angular_vel_max; else cmd->angular.z = angularV;
		velocity_pub.publish(cmd);
	} while (angleDiff>=0.01);

	double desiredYaw = currentYaw + pi;

	do{
		double angleDiff = desiredYaw - currentYaw;
		double angularV = ang_constant*angleDiff;

		if (angularV >= angular_vel_max) cmd->angular.z = angular_vel_max; else cmd->angular.z = angularV;
		velocity_pub.publish(cmd);
	} while (angleDiff>=0.01);

	cmd->angular.z = 0;

	ROS_INFO("velocity_control_node : reach goal. turning motors off...");
	kobuki_msgs::MotorPower power_cmd;
	power_cmd.state = kobuki_msgs::MotorPower::OFF;
	motpower_pub.publish(power_cmd);
	ROS_INFO("velocity_control_node : successfully powered down.");
	power_status = false;

	response.success = true;

	ROS_INFO("velocity_control_node : response sent");
	return true;
}

int main(int argc, char **argv)
{
	ros::init (argc, argv, "Velocity Controller");
	ros::NodeHandle node;

  	node.getParam("linear_vel_max", linear_vel_max);
  	node.getParam("angular_vel_max", angular_vel_max);
	node.getParam("velocity_constant", vel_constant);
	node.getParam("angularv_constant", ang_constant);
	
	ROS_INFO("Initialized the velocity_control_node");

	ros::Subscriber poition_sub = node.subscribe("position", 10, currentPositionCallback);
	
	ROS_INFO("velocity_control_node : created subscribers");

	ros::ServiceServer serviceDrive = node.advertiseService<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseControl", executionCallback);
	
	ROS_INFO("velocity_control_node : created service");

	ros::Publisher velocity_pub = node.advertise<geometry_msgs::Twist>("cmd_vel", 1);
	ros::Publisher motpower_pub = node.advertise<kobuki_msgs::MotorPower>("motor_power", 1);
	
	ROS_INFO("velocity_control_node : created publishers");

	cmd->linear.x = 0.0;
  	cmd->linear.y = 0.0;
  	cmd->linear.z = 0.0;
  	cmd->angular.x = 0.0;
  	cmd->angular.y = 0.0;
  	cmd->angular.z = 0.0;

	ROS_INFO("velocity_control_node : velocity message initialized");
	
	while (!connected)
	{
		if (motpower_pub.getNumSubscribers() > 0){
			connected = true;
			break;
		}
		
		if (count == 6){
			connected = false;
			break;
		} else {
			ROS_WARN_STREAM("velocity_control_node : could not connect with base, trying again after 500ms...");
			try {
				millisleep(500);
			} catch (ecl::StandardException e) {
				ROS_ERROR_STREAM("velocity_control_node : Waiting has been interrupted.");
				ROS_DEBUG_STREAM(e.what());
			}
			++count;
		}
	}

	if (!connected){
		ROS_ERROR("velocity_control_node : could not connect with base");
		ROS_ERROR("velocity_control_node : check remappings for enable/disable topics).");
	}

	ros::getGlobalCallbackQueue()->callAvailable(ros::WallDuration(0));

	return 0;
}