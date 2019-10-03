#include <cmath>
#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <tf/tfMessage.h>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2/LinearMath/Matrix3x3.h>
#include <geometry_msgs/TransformStamped.h>
#include <geometry_msgs/Transform.h>
#include <geometry_msgs/Vector3.h>

#include <geometry_msgs/Twist.h>
#include <kobuki_msgs/MotorPower.h>

#include <nav_planner/baseDrive.h>
#include <nav_planner/baseRotate.h>

octomap::point3d currentPosition;
octomap::point3d goalPosition;
geometry_msgs::Twist cmd;
kobuki_msgs::MotorPower power_cmd;

bool power_status = false;
bool connected = false;

int count = 0;

double linear_vel_max = 0.5;
double vel_constant = 0.2;
double angular_vel_max = 0.5;
double ang_constant = 0.2;
double Roll, Pitch, Yaw;
double pi = 3.14159265;
ros::Publisher velocity_pub;
ros::Publisher motpower_pub;

double angle;
double angleDiff;
double angularV;
double velocity;
double distance;
double currentYaw, desiredYaw;

void currentPositionCallback(const tf::tfMessage::ConstPtr &msg)
{
	octomap::point3d position = octomap::point3d(msg->transforms[0].transform.translation.x, msg->transforms[0].transform.translation.y, msg->transforms[0].transform.translation.z);
    
	tf2::Quaternion q(msg->transforms[0].transform.rotation.x, msg->transforms[0].transform.rotation.y, msg->transforms[0].transform.rotation.z, msg->transforms[0].transform.rotation.w);
	tf2::Matrix3x3 m(q);

	m.getRPY(Roll, Pitch, Yaw);
	currentPosition = position;

	if ((Yaw<3.14)&&(Yaw>-3.14)){
		currentYaw = Yaw;
	}
}

bool driveCallback(nav_planner::baseDrive::Request &request, nav_planner::baseDrive::Response &response)
{ 
	ROS_INFO("velocity_control_node : drive request received");

    goalPosition.x() = request.x;
	goalPosition.y() = request.y;
	goalPosition.z() = request.z;

	if (!power_status){
		ROS_INFO("velocity_control_node : motor was powered down. turning on now....");
		power_cmd.state = kobuki_msgs::MotorPower::ON;
		motpower_pub.publish(power_cmd);
		ROS_INFO("velocity_control_node : successfully powered up.");
		power_status = true;
	}
	
	desiredYaw = atan2(goalPosition.y()-currentPosition.y(), goalPosition.x()-currentPosition.x());

	do{
		angleDiff = desiredYaw - currentYaw;
		angularV = ang_constant*angleDiff;

		ROS_INFO("----");
		ROS_INFO_STREAM(desiredYaw);
		ROS_INFO_STREAM(currentYaw);
		ROS_INFO_STREAM(angleDiff);
		ROS_INFO_STREAM(angularV);

		if (angularV >= angular_vel_max) angularV = angular_vel_max;
		cmd.angular.z = angularV;
		velocity_pub.publish(cmd);
		ros::Duration(0.005).sleep();
	} while (std::abs(angleDiff)>=0.01);

	cmd.angular.z = 0;
	velocity_pub.publish(cmd);
	ros::Duration(0.005).sleep();
	ROS_INFO("velocity_control_node : successfully rotated");

	do{
		distance = goalPosition.distanceXY(currentPosition);
		velocity = distance*vel_constant;
		if (velocity >= linear_vel_max) velocity = linear_vel_max;
		cmd.linear.x = velocity;
		velocity_pub.publish(cmd);
		ros::Duration(0.005).sleep();
	} while (std::abs(distance)>=0.1);

	cmd.linear.x = 0;
	velocity_pub.publish(cmd);
	ROS_INFO("velocity_control_node : successfully moved");

	ROS_INFO("velocity_control_node : reached goal. turning motors off...");
	power_cmd.state = kobuki_msgs::MotorPower::OFF;
	motpower_pub.publish(power_cmd);
	ros::Duration(0.005).sleep();
	ROS_INFO("velocity_control_node : successfully powered down.");
	power_status = false;

	response.success = true;

	ROS_INFO("velocity_control_node : response sent");
	return true;
}

bool rotateCallback(nav_planner::baseRotate::Request &request, nav_planner::baseRotate::Response &response)
{ 
	ROS_INFO("velocity_control_node : rotate request received");

	if (!power_status){
		ROS_INFO("velocity_control_node : motor was powered down. turning on now....");
		power_cmd.state = kobuki_msgs::MotorPower::ON;
		motpower_pub.publish(power_cmd);
		ROS_INFO("velocity_control_node : successfully powered up.");
		power_status = true;
	}
	
	angle = request.angle;

	do{
		angleDiff = angle - currentYaw;
		angularV = ang_constant*angleDiff;

		ROS_INFO("----");
		ROS_INFO_STREAM(angle);
		ROS_INFO_STREAM(currentYaw);
		ROS_INFO_STREAM(angleDiff);
		ROS_INFO_STREAM(angularV);

		if (angularV >= angular_vel_max) angularV = angular_vel_max;
		cmd.angular.z = angularV;
		velocity_pub.publish(cmd);
		ros::Duration(0.005).sleep();
	} while (std::abs(angleDiff)>=0.01);

	cmd.angular.z = 0;
	velocity_pub.publish(cmd);
	ROS_INFO("velocity_control_node : successfully rotated");

	ROS_INFO("velocity_control_node : reach goal. turning motors off...");
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
	
	ROS_INFO("Initialized the velocity_control_node");

	ros::Subscriber poition_sub = node.subscribe("position", 1, currentPositionCallback);
	
	ROS_INFO("velocity_control_node : created subscribers");

	ros::ServiceServer serviceDrive = node.advertiseService<nav_planner::baseDriveRequest, nav_planner::baseDriveResponse>("baseForword", driveCallback);
	ros::ServiceServer serviceRotate = node.advertiseService<nav_planner::baseRotateRequest, nav_planner::baseRotateResponse>("baseRotate", rotateCallback);
	
	ROS_INFO("velocity_control_node : created service");

	velocity_pub = node.advertise<geometry_msgs::Twist>("cmd_vel", 1);
	motpower_pub = node.advertise<kobuki_msgs::MotorPower>("motor_power", 1);

	ROS_INFO("velocity_control_node : created publishers");

	cmd.linear.x = 0.0;
  	cmd.linear.y = 0.0;
  	cmd.linear.z = 0.0;
  	cmd.angular.x = 0.0;
  	cmd.angular.y = 0.0;
  	cmd.angular.z = 0.0;

	ROS_INFO("velocity_control_node : velocity message initialized");
	
	while (!connected)
	{
		if (motpower_pub.getNumSubscribers() > 0){
			connected = true;
			ROS_WARN_STREAM("velocity_control_node : connected with base");
			break;
		}
		
		if (count == 6){
			connected = false;
			break;
		} else {
			ROS_WARN_STREAM("velocity_control_node : could not connect with base, trying again after 500ms...");
			ros::Duration(0.5).sleep(); // sleep for half a second
			++count;
		}
	}

	if (!connected){
		ROS_ERROR("velocity_control_node : could not connect with base");
		ROS_ERROR("velocity_control_node : check remappings for enable/disable topics).");
	}

	ros::AsyncSpinner spinner (3);
	ros::Rate r(100);

	spinner.start();
	ros::waitForShutdown();

	return 0;
}