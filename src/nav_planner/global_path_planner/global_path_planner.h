#include<bits/stdc++.h> 
#include <octomap/octomap.h>
#include <octomap/OcTree.h>

#include <ros/console.h>

//map
#define ROW 800 
#define COL 800

//map + 2*(padding) 
#define INITROW 816
#define INITCOL 816

//map + 4*(padding)
#define PADROW 832
#define PADCOL 832

//Map boundries
#define MAPLOW -0.175
#define MAPHIGH 20.225
#define OFFSET 0.175
#define CELL 0.025
#define INVCELL 40  //multiply by 20 instead of dividing by cell size 0.05
#define UNITOFFSET 0.0125
#define MASKSIDE 17

//Robot description
#define HEIGHT 0.35
#define CLEARENCE_DISTANCE 1.5

//Pit detection range
#define MINDISTANCE 0.70
#define MAXDISTANCE 2.80

class global_path_planner{
    private:
        octomap::OcTree* tree_oct;
        octomap::point3d currentPosition;
        octomap::point3d goal;

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
        void update_tree(octomap::OcTree* receivedTree);
        bool search(std::vector<std::vector<int> > &grid, global_path_planner::Pair src, global_path_planner::Pair dest, std::vector<octomap::point3d> &outPath);
        void buildMap(std::vector<std::vector<int> > &initialGrid, std::vector<std::vector<int> > &processedGrid);
        void processPath(std::vector<octomap::point3d> &inPath, std::vector<octomap::point3d> &outPath);
        void saveOctomap(const std::string &filename);
};