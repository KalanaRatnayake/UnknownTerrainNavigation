#include<bits/stdc++.h> 
#include <octomap/octomap.h>
#include <octomap/OcTree.h>

//map
#define ROW 400 
#define COL 400

//map + 2*(padding) 
#define INITROW 408
#define INITCOL 408

//Map boundries
#define MAPLOW -0.2
#define MAPHIGH 20.2
#define OFFSET 0.175
#define CELL 0.05
#define INVCELL 20  //multiply by 20 instead of dividing by cell size 0.05

//map + 4*(padding)
#define PADROW 416
#define PADCOL 416

//Robot description
#define HEIGHT 0.35
#define CLEARENCE_DISTANCE 2

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
        bool search(int grid[][COL], Pair src, Pair dest, std::vector<octomap::point3d> &outPath);
        void buildMap(int (&outGrid)[INITROW][INITCOL]);
        void preprocessMap(int (&inGrid)[INITROW][INITCOL], int (&outGrid)[ROW][COL]);
        void cleanPath(std::vector<octomap::point3d> path);
        void saveOctomap(const std::string &filename);
};