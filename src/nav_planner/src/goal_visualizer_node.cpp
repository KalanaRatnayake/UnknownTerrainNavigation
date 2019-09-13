#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/ColorOcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <nav_planner/pointData.h>
#include <nav_planner/pointDataArray.h>

#include <goal_visualizer.h>

static int seq_num = 1; 

octomap::ColorOcTree outTree (0.05);
goal_visualizer visualizerObject = goal_visualizer(0.05);

void arrayCallback(const nav_planner::pointDataArray::ConstPtr &msg)
{
    std::vector<octomap::point3d> centerArray;
    for (int i=0; i< msg->centerPointsArray.size(); i++)
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

int main(int argc, char **argv){

	ros::init (argc, argv, "Goal_Visualizer");
	ros::NodeHandle node;

    ROS_INFO("Initialized the goal_visualizer_node");

    ros::Subscriber array_sub = node.subscribe("array", 1000, arrayCallback);
	ros::Subscriber goal_sub = node.subscribe("goal", 10, goalCallback);

    ROS_INFO("goal_visualizer_node : subscribers created");

	ros::Publisher map_pub = node.advertise<octomap_msgs::Octomap>("octomap_centers", 1, true);

    ROS_INFO("goal_visualizer_node : publishers advertised");

	while(ros::ok()){

        visualizerObject.get_tree(outTree);

        octomap_msgs::Octomap map_msg;
        
        octomap_msgs::fullMapToMsg(outTree, map_msg); // (.ot)

        map_msg.header.frame_id = "/odom";
        map_msg.header.stamp = ros::Time::now();
        map_msg.header.seq = seq_num;  seq_num+=1;

        map_pub.publish(map_msg);
        
        ros::getGlobalCallbackQueue()->callAvailable(ros::WallDuration(0.001));
    }

	return 0;
}

  
