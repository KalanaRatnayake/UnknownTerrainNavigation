#include "global_path_planner.h"

void global_path_planner::global_path_planner(double bodyWidth){
    pace = bodyWidth;
}

void global_path_planner::createPath(octomap::point3d &current, octomap::point3d &next, std::vector<octomap::point3d> &outPath){
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

/*
/distances and counts will be in 2 different arrays.
/
/distanceArray = {left_min, left_max, right_min, right_max}
/countsArray = {left_out, left_in, right_out, right_in}
/
*/

void global_path_planner::checkPoint(octomap::point3d &current, octomap::point3d &next, float &distanceArray [4]){
    float lenMargin = maskSideLen*0.25;
    float left_min, right_min, offset = maskSideLen*0.5;
    float left_max, right_max = 0;


    // for detecting obstacles in the current path

    for (int kz=1 kz<botHeight; kz++){
        for (int kx=0; kx<maskSide; kx++){
            for (int ky=0; ky<maskSide; ky++){

                if (robotMask[kx][ky]){
                    float x = next.x() + kx*resolution - offset;
                    float y = next.y() + ky*resolution - offset;
                    float z = kz*resolution;

                    if (tree->search(x,y,z)){
                        octomap::OcTreeNode* node = tree->search(x,y,z);

                        if (tree ->isNodeOccupied(node)){
                            int sign = ((next.x()-current.x())*(y-current.y()))-((next.y()-current.y())*(x-current.x()));

                            float m = (next.y()-current.y())/(next.x()-current.x());
                            float k = current.y() - (m*current.x());

                            float len = (y - (m*x) - k)/sqrt(1+(m*m));  //shortest distance to moving direction

                            if (sign > 0){              //left
                                if (left_min > len) left_min = len;
                                if (left_max < len) left_max = len;
                            }
                            else if (sign < 0){         //right
                                if (right_min > len) right_min = len;
                                if (right_max < len) right_max = len;
                            }
                            else{                       //on the line
                                right_min = 0;
                                left_min = 0;
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
                    float x = next.x() + kx*resolution - offset;
                    float y = next.y() + ky*resolution - offset;
                    float z = 0;

                    if (tree->search(x,y,z)){
                        octomap::OcTreeNode* node = tree->search(x,y,z);

                        if (!tree ->isNodeOccupied(node)){
                            int gsign = ((next.x()-current.x())*(y-current.y()))-((next.y()-current.y())*(x-current.x()));

                            float m = (next.y()-current.y())/(next.x()-current.x());
                            float k = current.y() - (m*current.x());float &outDistanceArray [4]

                            float glen = (y - (m*x) - k)/sqrt(1+(m*m));

                            if (gsign > 0){
                                if (left_min > glen) left_min = glen;
                                if (left_max < glen) left_max = glen;
                            }
                            else if (gsign < 0){
                                if (right_min > glen) right_min = glen;
                                if (right_max < glen) right_max = glen;
                            }
                            else{
                                right_min = 0;
                                left_min = 0;
                            }
                        }                        
                    }      
                }               
            }
        }
    distanceArray = {left_min, left_max, right_min, right_max};
}

bool global_path_planner::updatePoint(octomap::point3d &current, octomap::point3d &next, float &distanceArray [4], octomap::point3d &updated){
    left_min = distanceArray[0];
    left_max = distanceArray[1];
    right_min = distanceArray[2];
    right_max = distanceArray[3];

    bool success = false;

    float margin = maskSideLen*0.5;
    float toLeft, toRight = 0;

    if ((right_max>0) && (right_min>0) && (left_max==0) && (left_min==margin)){
        toLeft = margin - right_min;

    } else if ((right_max==margin) && (right_min==0) && (left_max>=0) && (left_min==0)){
        toLeft = right_max + left_max;

    } else if ((left_max>0) && (left_min>0) && (right_max==0) && (right_min==margin)) {
        toRight = margin - left_min;

    } else if ((left_max==margin) && (left_min==0) && (right_max>=0) && (right_min==0){
        toRight = right_max + left_max;

    } else if ((left_max>0) && (left_min==0) && (right_max>0) && (right_min==0)) {
        if (left_max>right_max) toRight = margin + right_max; else toleft = margin + left_max;

    } else if ((right_max==0) && (right_min==margin) && (left_max==0) && (left_min==margin)){
        toLeft = 0;
        toRight = 0;
        success = true;

    } else {
        ROS_INFO("Didnt encounter instance");
        ROS_INFO_STREAM(distanceArray);
    }

    float m = (next.y()-current.y())/(next.x()-current.x());
    
    if (toLeft>toRight){
        float x = next.x() + toLeft*sqrt((m*m)/((m*m) + 1));
        float y = next.y() - toLeft*sqrt(1/((m*m) + 1));
    } else if (toLeft<>>toRight){
        float x = next.x() - toRight*sqrt((m*m)/((m*m) + 1));
        float y = next.y() + toRight*sqrt(1/((m*m) + 1));
    } else {
        float x = next.x();
        float y = next.y();
    }
    
    updatedOut.x() = x;
    updatedOut.y() = y;
    updatedOut.z() = next.z();

    return success;
}

void global_path_planner::updateCurrentPoint(octomap::point3d &position){
    currentPosition = position;
}

void global_path_planner::updateGoalPoint(octomap::point3d &position){
    goalPosition = position;
}

void global_path_planner::updateTree(octomap::Octree* receivedTree){
    tree = receivedTree;
}

void global_path_planner::getNextPosition(octomap::point3d &outNextPosition){
    std::vector <octomap::point3d> path;
    float distanceArray [4];
    octomap::point3d nextPosition;
    octomap::point3d updatedPoint;
    bool trigger;

    createPath(currentPosition, goalPosition, path);

    nextPosition = path[0];

    checkPoint(currentPosition, nextPosition, distanceArray);
    trigger = updatePoint(currentPosition, nextPosition, distanceArray, updatedPoint);

    while (!trigger){
        nextPosition = updatedPoint;
        checkPoint(currentPosition, nextPosition, distanceArray);
        trigger = updatePoint(currentPosition, nextPosition, distanceArray, updatedPoint);
    }
    
    outNextPosition = updatedPoint;
}