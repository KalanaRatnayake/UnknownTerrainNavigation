#include "global_path_planner.h"

double pace;
int botHeight = 9;
int maskSide = 9;
float resolution = 0.05; 

bool robotMask [maskSide][maskSide]= {
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

global_path_planner::global_path_planner(double bodyWidth){
    pace = bodyWidth;
}

global_path_planner::createPath(octomap::point3d &current, octomap::point3d &next, std::vector<octomap::point3d> &outPath){
    std::vector<octomap::point3d> path;

    double distance =  next.distance(current);
    int noPoints = (int) distance/pace;

    double dx = (next.x()-current.x())/noPoints;
    double dy = (next.y()-current.y())/noPoints;
    double dz = (next.z()-current.z())/noPoints;

    for (int i=0; i< noPoints; i++){
        octomap::point3d node;

        node.x() = current.x() + i*dx;
        node.y() = current.y() + i*dy;
        node.z() = current.z() + i*dz;

        path.push_back(node);
    }

    path.push_back(next);

    outPath = path;
}

global_path_planner::checkPoint(octomap::point3d &current, octomap::point3d &next, 
                                float &leftDis, float &rightDis, int &leftCo, int &middleCo, int &rightCo, 
                                float &gleftDis, float &grightDis, int &gleftCo, int &gmiddleCo, int &grightCo){
    
    float left, right, initLeft, initRight, gleft, gright, ginitLeft, ginitRight = ((float) maskSide)/2;
    int leftCount, rightCount, middleCount, gleftCount, grightCount, gmiddleCount = 0;

    // for detecting obstacles in the current path

    for (int kz=1 kz<botHeight; kz++){
        for (int kx=0; kx<maskSide; kx++){
            for (int ky=0; ky<maskSide; ky++){

                if (robotMask[kx][ky]){
                    float x = next.x() + kx*resolution - initRight*resolution;
                    float y = next.y() + ky*resolution - initLeft*resolution;
                    float z = kz*resolution;

                    if (tree->search(x,y,z)){
                        octomap::OcTreeNode* node = tree->search(x,y,z);

                        if (tree ->isNodeOccupied(node)){
                            int sign = ((next.x()-current.x())*(y-current.y()))-((next.y()-current.y())*(x-current.x()));

                            float m = (next.y()-current.y())/(next.x()-current.x());
                            float k = current.y() - (m*current.x());

                            float len = (y - (m*x) - k)/sqrt(1+(m*m));

                            if (sign > 0){
                                if (left > len){
                                    left = len;
                                }
                                leftCount++;
                            }
                            else if (sign < 0){
                                if (right > len){
                                    right = len;
                                }
                                rightCount++;
                            }
                            else{
                                left = 0;
                                right = 0;
                                middleCount++;
                            }
                        }                        
                    }      
                }               
            }
        }
    }

    //for detecting holes in the floor

    for (int kx=0; kx<maskSide; kx++){
            for (int ky=0; ky<maskSide; ky++){

                if (robotMask[kx][ky]){
                    float x = next.x() + kx*resolution - ginitRight*resolution;
                    float y = next.y() + ky*resolution - ginitLeft*resolution;
                    float z = 0;

                    if (tree->search(x,y,z)){
                        octomap::OcTreeNode* node = tree->search(x,y,z);

                        if (!tree ->isNodeOccupied(node)){
                            int gsign = ((next.x()-current.x())*(y-current.y()))-((next.y()-current.y())*(x-current.x()));

                            float m = (next.y()-current.y())/(next.x()-current.x());
                            float k = current.y() - (m*current.x());

                            float glen = (y - (m*x) - k)/sqrt(1+(m*m));

                            if (gsign > 0){
                                if (gleft > glen){
                                    gleft = glen;
                                }
                                gleftCount++;
                            }
                            else if (gsign < 0){
                                if (gright > glen){
                                    gright = glen;
                                }
                                grightCount++;
                            }
                            else{
                                gleft = 0;
                                gright = 0;
                                gmiddleCount++;
                            }
                        }                        
                    }      
                }               
            }
        }

    leftDis = initLeft - left;
    rightDis = initRight - right;
    leftCo = leftCount;
    middleCo = middleCount;
    rightCo = rightCount;
    gleftDis = ginitLeft - gleft;
    grightDis = ginitRight - gright;
    gleftCo = gleftCount;
    gmiddleCo = gmiddleCount;
    grightCo = grightCount;
}

global_path_planner::updatePoint(octomap::point3d &current, octomap::point3d &previous){

}