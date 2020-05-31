#include<bits/stdc++.h> 
#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <memory>
#include <mutex>

#include <ros/console.h>

//map
#define ROW 200
#define COL 200

//map + 2*(padding) 
#define INITROW 224
#define INITCOL 224

//map + 4*(padding)
#define PADROW 248
#define PADCOL 248

//Map boundries
#define MAPLOW -0.275
#define MAPHIGH 5.325
#define OFFSET 0.275
#define CELL (float)0.025
#define INVCELL 40  //multiply by 20 instead of dividing by cell size 0.05
#define UNITOFFSET 0.0125
#define MASKSIDE 25
#define PADDING 12

//Robot description
#define HEIGHT 0.35
#define CLEARENCE_DISTANCE 2.5

//Pit detection range
#define MINDISTANCE 0.70
#define MAXDISTANCE 3.50

class global_path_planner{
    private:
        std::shared_ptr<octomap::OcTree> tree_oct;
        octomap::point3d currentPosition;
        octomap::point3d goal;
        std::mutex* plannerMutex;

    public:
        typedef std::pair<int, int> Pair; 
        typedef std::pair<double, std::pair<int, int> > pPair;

        struct cell { 
            int parent_i, parent_j;
            double f, g, h; 
        }; 
        
        global_path_planner();
        void update_goal(octomap::point3d &position);
        void update_position(octomap::point3d &position);
        void update_tree(std::shared_ptr<octomap::OcTree> receivedTree);
        bool search(std::vector<std::vector<int> > &grid, global_path_planner::Pair src, global_path_planner::Pair dest, std::vector<octomap::point3d> &outPath);
        void buildMap(std::vector<std::vector<int> > &discoveredGrid, std::vector<std::vector<int> > &initialGrid, std::vector<std::vector<int> > &processedGrid);
        void processPath(std::vector<octomap::point3d> &inPath, std::vector<std::vector<int> > &discoveredGrid, std::vector<octomap::point3d> &outPath);
        bool isBlocked(octomap::point3d &point, std::vector<std::vector<int> > &grid);
        void reducePath(std::vector<octomap::point3d> &inPath, std::vector<octomap::point3d> &outPath);
        void nearestUnBlocked(octomap::point3d &blockedPoint, std::vector<std::vector<int> > &grid, octomap::point3d &freePoint);
};