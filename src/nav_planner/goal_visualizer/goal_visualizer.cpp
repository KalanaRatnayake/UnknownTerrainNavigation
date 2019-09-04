#include "goal_visualizer.h"

goal_visualizer::goal_visualizer(double inputResolution){
    tree = new octomap::ColorOcTree(inputResolution);
}

void goal_visualizer::update_cluster_centers(std::vector<octomap::point3d> &inCenterPointsArray){
    ROS_INFO("goal_visualizer : inside update cluster centers callback");

    int len = inCenterPointsArray.size();

    for(int i=0; i<len; i++){
        octomap::ColorOcTreeNode* n = tree->updateNode(inCenterPointsArray[i], true);
        n->setColor(255, 0, 0); // set color to red
    }

    ROS_INFO("goal_visualizer : exiting update cluster centers callback");
}

void goal_visualizer::update_nearest_cluster(octomap::point3d &nearestCluster){

    ROS_INFO("goal_visualizer : inside update nearest cluster callback");

    octomap::ColorOcTreeNode* n = tree->updateNode(nearestCluster, true);
    n->setColor(0, 255, 0); // set color to green

    ROS_INFO("goal_visualizer : exiting update nearest cluster callback");
}

void goal_visualizer::get_tree(octomap::ColorOcTree* outTree){
    outTree = tree;
}
