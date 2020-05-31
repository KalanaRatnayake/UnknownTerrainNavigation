#include <ros/ros.h>
#include <ros/console.h>
#include <ros/callback_queue.h>

#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <octomap_msgs/Octomap.h>
#include <octomap_msgs/conversions.h>

#include <chrono>
#include <memory>

#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>

#include <nav_msgs/Odometry.h>
#include <sensor_msgs/Imu.h>

//Map boundries
#define MAPWIDTH 5.00
#define MAPLENGTH 5.00
#define MAPHEIGHT 0.75
#define CELL 0.05
#define UNITOFFSET 0.025

//time variables
std::chrono::system_clock::time_point start_time_map, current_time_map;
std::chrono::system_clock::time_point previ_time_call, current_time_call;
bool finised = false;

//path length metric variables
float distance = 0;
octomap::point3d previousPosition = octomap::point3d(0,0,0);

//curvature change variables
float curvature;
float curvature_old = 0;
float total_curvature = 0;

//lateral stress variables
float latStress;
float latStress_old = 0; 
float total_latStress = 0;

//tangential stress variables
float acc;
float acc_old = 0;
float acc_total = 0;

//writing to file
std::ofstream graphfile("/home/kalana/Desktop/graph_percentage.txt");
std::ofstream accumfile("/home/kalana/Desktop/accumilated_values.txt");

void mapCallback(const octomap_msgs::Octomap::ConstPtr &msg){

    current_time_map = std::chrono::system_clock::now();
    long int spent_mili =  std::chrono::duration_cast<std::chrono::milliseconds>(current_time_map - start_time_map).count();
    float spent_sec = ((float) spent_mili)/1000;
    std::shared_ptr<octomap::OcTree> tree = std::shared_ptr<octomap::OcTree> (dynamic_cast<octomap::OcTree*> (octomap_msgs::msgToMap(*msg)));

    float discovered_count = 0;
    float not_discov_count = 0;

    // explored percentage metric

    for (float z=UNITOFFSET; z<MAPHEIGHT; z+=CELL){
        for (float x=UNITOFFSET; x<MAPLENGTH; x+=CELL){
        for (float y=UNITOFFSET; y<MAPWIDTH; y+=CELL){
            if (tree->search(x, y, z)){
            discovered_count++;
            } else {
            not_discov_count++;
            }
        }
        }
    }

    float discov_percentage = (discovered_count*100)/(discovered_count+not_discov_count);
    
    graphfile << spent_sec << "," << discov_percentage << "\n";

    if (not_discov_count==0){
        finised = true;
        accumfile << "total time" << " : " << spent_sec << "\n";
    }
}

void callback(const nav_msgs::Odometry::ConstPtr &msgOdom, const sensor_msgs::Imu::ConstPtr& msgImu){
	
    //time evaluation
    current_time_call = std::chrono::system_clock::now();
    long int time_mili =  std::chrono::duration_cast<std::chrono::milliseconds>(current_time_call - previ_time_call).count();
    float time_sec = ((float) time_mili)/1000;
    previ_time_call = current_time_call;

    // path length metric
    octomap::point3d currentPosition = octomap::point3d(msgOdom->pose.pose.position.x, msgOdom->pose.pose.position.y, msgOdom->pose.pose.position.z);
    distance += currentPosition.distance(previousPosition);
    previousPosition = currentPosition;
    
    accumfile << "Path length" << " : " << distance << "\n";

    float lin_vel = msgOdom->twist.twist.linear.x;  //robot can move only in the x direction
    float ang_vel = msgOdom->twist.twist.angular.z; //robot can only change the yaw value.
    float acc_raw = msgImu ->linear_acceleration.x; //robot can only accelerate in x direction

    //curvature change
    if (lin_vel != 0)
    {
        curvature = std::abs(ang_vel/lin_vel);
        total_curvature += std::abs(curvature-curvature_old);
        curvature_old = curvature;
    }

    accumfile << "curvature change" << " : " << total_curvature << "\n";

    // lateral stress metric
    latStress = std::abs(ang_vel*lin_vel);
    total_latStress += (latStress + latStress_old)*time_sec*0.5;
    latStress_old = latStress;
    
    accumfile << "Lateral stress" << " : " << total_latStress << "\n";

    // tangential stress metric
    acc = std::abs(acc_raw);
    acc_total += (acc + acc_old)*time_sec*0.5;
    acc_old = acc;
    
    accumfile << "tangential stress" << " : " << acc_total << "\n";
    accumfile << "\n";
}

int main(int argc, char **argv)
{
    previ_time_call = std::chrono::system_clock::now();
    start_time_map = std::chrono::system_clock::now();

    ros::init(argc, argv, "evaluator");
    ros::NodeHandle n;

    ros::Subscriber sub_map = n.subscribe("octomap", 1, mapCallback);

    //subscribe to rgb_image topic and pointCloud topic
    message_filters::Subscriber<sensor_msgs::Imu> imu_sub(n, "imu", 20);
    message_filters::Subscriber<nav_msgs::Odometry> odom_sub(n, "odometry", 20);

    message_filters::TimeSynchronizer<nav_msgs::Odometry, sensor_msgs::Imu> sync(odom_sub, imu_sub, 10);
    sync.registerCallback(callback);

    ros::AsyncSpinner spinner (3);
    ros::Rate r(200);

    spinner.start();

    ros::waitForShutdown();
    return 0;
}
