#include <vector>
#include <ros/console.h>
#include <octomap/octomap.h>
#include <octomap/OcTree.h>
#include <cmath>

class global_path_planner
{

    private:
        double pace;
        int botHeight;
        int maskSide;
        float resolution;
        float maskSideLen;
        float left_min, left_max, right_min, right_max;

        octomap::OcTree* tree;
        octomap::point3d currentPosition;
        octomap::point3d goalPosition;

        void createPath(octomap::point3d &current, octomap::point3d &next, std::vector<octomap::point3d> &outPath);
        void checkPoint(octomap::point3d &current, octomap::point3d &next);
        bool updatePoint(octomap::point3d &current, octomap::point3d &next, octomap::point3d &updated);

    public:
        global_path_planner(double bodyWidth, int botHeightBlocks, int maskSideBlocks, float resolutionValue);
        void updateCurrentPoint(octomap::point3d &position);
        void updateGoalPoint(octomap::point3d &position);
        void updateTree(octomap::OcTree* receivedTree);
        void getNextPosition(octomap::point3d &outNextPosition);
};