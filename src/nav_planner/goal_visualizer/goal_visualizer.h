#include <vector>
#include <ros/console.h>
#include <octomap/octomap.h>
#include <octomap/ColorOcTree.h>
#include <cmath>

class goal_visualizer{
    private:
        octomap::ColorOcTree* tree;
    
    public:
        goal_visualizer(double inputResolution);
        void update_cluster_centers(std::vector<octomap::point3d> &inCenterPointsArray);
        void update_nearest_cluster(octomap::point3d &inCluster);
        void get_tree(octomap::ColorOcTree &outTree);
};
