#include <ros/ros.h>
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
    std::vector<octomap::point3d> centerArray;
    for (int i=0; i<msg->centerPointsArray.size(); i++)
    {
        octomap::point3d position = octomap::point3d(msg->centerPointsArray[i].x, msg->centerPointsArray[i].y, msg->centerPointsArray[i].z);
        centerArray.push_back(position);
    }

	visualizerObject.update_cluster_centers(centerArray);
}

void goalCallback(const nav_planner::pointData::ConstPtr &msg)
{
	octomap::point3d goal = octomap::point3d(msg->x, msg->y, msg->z);

    visualizerObject.update_nearest_cluster(goal);
}


int main(int argc, char **argv)
{
    octomap::ColorOcTree* outTree;
    octomap_msgs::Octomap map_msg;

	ros::init (argc, argv, "Goal_Identifier");
	ros::NodeHandle node;

    ros::Subscriber array_sub = node.subscribe("centerArray", 1000, arrayCallback);
	ros::Subscriber goal_sub = node.subscribe("goalPoint", 1, goalCallback);

	ros::Publisher map_pub = node.advertise<octomap_msgs::Octomap>("centersMap", 1);

	while(ros::ok()){
        visualizerObject.get_tree(outTree);
        octomap_msgs::fullMapToMsg(*outTree, map_msg); // (.ot)

		map_pub.publish(map_msg);
	}

	ros::spin();
	return 0;
}

  
