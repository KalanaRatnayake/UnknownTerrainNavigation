#include "goal_visualizer.h"

goal_visualizer::goal_visualizer(double inputResolution){
    tree = new octomap::ColorOcTree(inputResolution);
    resolution = inputResolution;
}

void goal_visualizer::update_cluster_centers(std::vector<octomap::point3d> &inCenterPointsArray){
    tree -> clear();

    for(int i=0; i<inCenterPointsArray.size(); i++){
        octomap::ColorOcTreeNode* n = tree->updateNode(inCenterPointsArray[i], true);
        n->setColor(255, 0, 0); // set color to red
    }
}

void goal_visualizer::update_nearest_cluster(octomap::point3d &nearestCluster){

    octomap::ColorOcTreeNode* n = tree->updateNode(nearestCluster, true);
    n->setColor(0, 255, 0); // set color to green
}

void goal_visualizer::get_tree(octomap::ColorOcTree &outTree){
    outTree.clear();

    for(octomap::ColorOcTree::leaf_iterator it = tree->begin_leafs(), end = tree->end_leafs(); it!=end; ++it){

        octomap::point3d node(it.getX(), it.getY(),it.getZ());
            
        if(it->getValue()>0.0){
            outTree.updateNode(node, true);
            octomap::ColorOcTreeNode* key = outTree.search(it.getX(), it.getY(), it.getZ());
            key->setColor(it->getColor());

        }else{
            outTree.updateNode(node, false);
        }
    }
}
