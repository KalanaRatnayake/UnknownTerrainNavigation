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
        float maskSideLen = maskSide*resolution;

        bool robotMask [9][9];

        octomap::OcTree* tree;
        octomap::point3d currentPosition;
        octomap::point3d goalPosition;

        void createPath(octomap::point3d &current, octomap::point3d &next, std::vector<octomap::point3d> &outPath);
        void checkPoint(octomap::point3d &current, octomap::point3d &next, float &distanceArray [4]);
        bool updatePoint(octomap::point3d &current, octomap::point3d &next, float &distanceArray [4], octomap::point3d &updated);

    public:
        void global_path_planner(double bodyWidth, int botHeightBlocks, int maskSideBlocks, float resolutionValue, bool &mask [9][9]);
        void updateCurrentPoint(octomap::point3d &position);
        void updateGoalPoint(octomap::point3d &position);
        void updateTree(octomap::OcTree* tree);
        void getNextPosition(octomap::point3d &outNextPosition);
};