#include <vector>
#include <ros/console.h>
#include <octomap/octomap.h>
#include <octomap/OcTree.h>
#include <cmath>

class global_path_planner
{

    private:
        double pace;
        int botHeight = 9;
        int maskSide = 9;
        float resolution = 0.05;
        float maskSideLen = maskSide*resolution;

        bool robotMask [9][9]= {
            {false, false,  true,  true,  true,  true,  true, false, false},
            {false,  true,  true,  true,  true,  true,  true,  true, false},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            { true,  true,  true,  true,  true,  true,  true,  true,  true},
            {false,  true,  true,  true,  true,  true,  true,  true, false},
            {false, false,  true,  true,  true,  true,  true, false, false},
        };

        octomap::OcTree* tree;
        octomap::point3d currentPosition;
        octomap::point3d goalPosition;

        void createPath(octomap::point3d &current, octomap::point3d &next, std::vector<octomap::point3d> &outPath);
        
        /*
        /distances and counts will be in 2 different arrays.
        /
        /distanceArray = {left_min, left_max, right_min, right_max}
        /countsArray = {left_out, left_in, right_out, right_in}
        /
        */
        void checkPoint(octomap::point3d &current, octomap::point3d &next, float &distanceArray [4]);
        bool updatePoint(octomap::point3d &current, octomap::point3d &next, float &distanceArray [4], octomap::point3d &updated);

    public:
        void global_path_planner();
        void updateCurrentPoint(octomap::point3d &position);
        void updateGoalPoint(octomap::point3d &position);
        void updateTree(octomap::OcTree* tree);
        void getNextPosition(octomap::point3d &outNextPosition);
};