#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>
#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>
#include <octomap/octomap.h>
#include <octomap/ColorOcTree.h>
#include <nav_msgs/Odometry.h>
#include <nav_planner/pointData.h>
#include <nav_planner/pointDataArray.h>
#include <nav_planner/goalControl.h>
#include <goal_visualizer.h>


goal_visualizer visualizerObject = goal_visualizer(0.05);

void arrayCallback(const nav_planner::pointDataArray::ConstPtr &msg)
{
    ROS_INFO("goal_visualizer_node : inside arrayCallback");

    std::vector<octomap::point3d> centerArray;

    ROS_INFO("goal_visualizer_node : msg converting to array");

    for (int i=0; i<msg->centerPointsArray.size(); i++)
    {
        octomap::point3d position = octomap::point3d(msg->centerPointsArray[i].x, msg->centerPointsArray[i].y, msg->centerPointsArray[i].z);
        centerArray.push_back(position);
    }

    ROS_INFO("goal_visualizer_node : msg converting to array: completed");

	visualizerObject.update_cluster_centers(centerArray);

    ROS_INFO("goal_visualizer_node : updated visualizerObject, exiting arrayCallback");
}

void goalCallback(const nav_planner::pointData::ConstPtr &msg)
{

    ROS_INFO("goal_visualizer_node : inside goalcallback msg converting to goal");
	octomap::point3d goal = octomap::point3d(msg->x, msg->y, msg->z);

    visualizerObject.update_nearest_cluster(goal);

    ROS_INFO("goal_visualizer_node : updated visualizerObject, exiting goalCallback");
}


int main(int argc, char **argv){

	ros::init (argc, argv, "Goal_Identifier");
	ros::NodeHandle node;

    ROS_INFO("Initialized the goal_visualizer_node");

    ros::Subscriber array_sub = node.subscribe("array", 1000, arrayCallback);
	ros::Subscriber goal_sub = node.subscribe("goal", 10, goalCallback);

    ROS_INFO("goal_visualizer_node : subscribers created");

	ros::Publisher map_pub = node.advertise<octomap_msgs::Octomap>("octomap_centers", 5, true);

    ROS_INFO("goal_visualizer_node : publishers advertised");

	while(ros::ok()){
        octomap::ColorOcTree* outTree;
        octomap_msgs::Octomap map_msg;
        
        ROS_INFO("goal_visualizer_node : inside while loop");
        visualizerObject.get_tree(outTree);
        ROS_INFO("goal_visualizer_node : outtree retreieved");

        map_msg.header.frame_id = "/odom";
        octomap_msgs::fullMapToMsg(*outTree, map_msg); // (.ot)

        ROS_INFO("goal_visualizer_node : converted to msg");

		map_pub.publish(map_msg);

        ROS_INFO("goal_visualizer_node : published map");
        
        ros::getGlobalCallbackQueue()->callAvailable(ros::WallDuration(0.1));
	}

	return 0;
}

  
