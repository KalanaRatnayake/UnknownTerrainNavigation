#include <vector>
#include <ros/console.h>
#include <octomap/octomap.h>
#include <octomap/OcTree.h>
#include <cmath>
#include <memory>
#include <mutex>

class goal_identifier
{
    private:
        std::shared_ptr<octomap::OcTree> tree;
        octomap::point3d position;
        std::vector<octomap::point3d> ignorePoints;
        int xn, yn, zn;
        float resolution;
        float percentage;
        float sideSize;
        float height;
        std::mutex* identifierMutex;
    
    private:
        void discover_clusters(std::vector<octomap::point3d> &outCenterPointsArray);
        void find_nearest_cluster(std::vector<octomap::point3d>  &unknownClusterCenters, octomap::point3d &outCluster, bool &completed);

    public:
        goal_identifier(float robotHeight, float clusterSize, double inputResolution, float x_distance, float y_distance, float z_distance, float clusterMargin);
        void update_position(octomap::point3d &currentPosition);
        void update_tree(std::shared_ptr<octomap::OcTree> receivedTree);
        void calculate(std::vector<octomap::point3d> &centerPointsArray, octomap::point3d &goal, bool &completed);
        void remove(octomap::point3d &point);
};
