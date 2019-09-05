#include "goal_visualizer.h"

goal_visualizer::goal_visualizer(double inputResolution){
    tree = new octomap::ColorOcTree(inputResolution);
}

void goal_visualizer::update_cluster_centers(std::vector<octomap::point3d> &inCenterPointsArray){

    int len = inCenterPointsArray.size();

    for(int i=0; i<len; i++){
        octomap::ColorOcTreeNode* n = tree->updateNode(inCenterPointsArray[i], true);
        n->setColor(255, 0, 0); // set color to red
    }
}

void goal_visualizer::update_nearest_cluster(octomap::point3d &nearestCluster){

    octomap::ColorOcTreeNode* n = tree->updateNode(nearestCluster, true);
    n->setColor(0, 255, 0); // set color to green
}

void goal_visualizer::get_tree(octomap::ColorOcTree* outTree){
    outTree = tree;
}
