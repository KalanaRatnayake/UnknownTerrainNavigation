#include <vector>
#include <ros/console.h>
#include <octomap/octomap.h>
#include <octomap/OcTree.h>
#include <cmath>

class global_path_planner
{

    private:
        void createPath(octomap::point3d &current, octomap::point3d &next, std::vector<octomap::point3d> &outPath);
        
        void checkPoint(octomap::point3d &current, octomap::point3d &next, 
                        float &leftDis, float &rightDis, int &leftCo, int &middleCo, int &rightCo, 
                        float &gleftDis, float &grightDis, int &gleftCo, int &gmiddleCo, int &grightCo);

        void updatePoint(octomap::point3d &current, octomap::point3d &previous);

    public:
        void global_path_planner();
        void updateCurrentPoint(octomap::point3d &position);
        void updateGoalPoint(octomap::point3d &position);
        void updateTree(octomap::OcTree* tree);
        void getNextPosition(octomap::point3d &nextPosition);
};