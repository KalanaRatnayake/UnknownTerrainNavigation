#include <goal_identifier.h>
    

goal_identifier::goal_identifier(float robotHeight, float clusterSize, double inputResolution, float x_distance, float y_distance, float z_distance, float clusterMargin){
    resolution = inputResolution;
    percentage = clusterMargin;
    sideSize = clusterSize;
    height = robotHeight;

    xn = (int) x_distance/(sideSize*resolution);
    yn = (int) y_distance/(sideSize*resolution);
    zn = (int) z_distance/(sideSize*resolution);
}
        
void goal_identifier::update_tree(octomap::OcTree* receivedTree){
    tree = receivedTree;
}

void goal_identifier::update_position(octomap::point3d &currentPosition){
    position = currentPosition;
}
        
void goal_identifier::discover_clusters(std::vector<octomap::point3d> &outCenterPointsArray){

    octomap::point3d centerPointsArray [xn*yn*zn];
    std::vector<octomap::point3d> unknownPointsArray;
            
    int index = 0;
            
    for (int x=0; x<xn; x++){
        for (int y=0; y<yn; y++){
            for (int z=0; z<zn; z++){
                centerPointsArray[index] = octomap::point3d ((sideSize*resolution)*(x+0.5), (sideSize*resolution)*(y+0.5), (sideSize*resolution)*(z+0.5));
                index++;
            }
        }
    }
            
    for (int i=0; i<index; i++){
        int counter = 0;
        
        float x_min = centerPointsArray[i].x()-((sideSize-1)*0.5*resolution);
        float x_max = centerPointsArray[i].x()+(sideSize*0.5*resolution);
        float y_min = centerPointsArray[i].y()-((sideSize-1)*0.5*resolution);
        float y_max = centerPointsArray[i].y()+(sideSize*0.5*resolution);
        float z_min = centerPointsArray[i].z()-((sideSize-1)*0.5*resolution);
        float z_max = centerPointsArray[i].z()+(sideSize*0.5*resolution);

        for (float a=x_min; a<x_max; a+=resolution){
            for (float b=y_min; b<y_max; b+=resolution){
                for (float c=z_min; c<z_max; c+=resolution){
                    if (!tree->search(a, b, c)){
                        counter++;
                    }
                }
            }
        }

        if (counter>=(percentage*sideSize*sideSize*sideSize)){
            unknownPointsArray.push_back(centerPointsArray[i]);
        }
    }

    outCenterPointsArray.clear();
    outCenterPointsArray = unknownPointsArray;

}

void goal_identifier::find_nearest_cluster(std::vector<octomap::point3d>  &unknownClusterCenters, octomap::point3d &outCluster){

    std::vector<octomap::point3d> lowerClusters;
    std::vector<octomap::point3d> upperClusters;
    std::vector<octomap::point3d> selectedClusters;

    int len = unknownClusterCenters.size();

    for(int i=0; i<len; i++){
        octomap::point3d cluster = unknownClusterCenters[i];

        if (cluster.z()>= height){
            upperClusters.push_back(cluster);
        } else {
            lowerClusters.push_back(cluster);
        }
    }

    if (lowerClusters.size()>0){
        selectedClusters = lowerClusters;

    } else {
        int upperLen = upperClusters.size();

        for(int i=0; i<upperLen; i++){
            octomap::point3d cluster = upperClusters[i];
            octomap::point3d newClusterX, newClusterY;

            newClusterX.z() = height/2;
            newClusterX.y() = cluster.y();

            float k = ((cluster.z()-(height*0.5))/ 0.36397) + cluster.x();  //divided by tan20 because verticle view angle of kinect is 43 degrees

            if (k > (xn*sideSize*resolution)){
                newClusterX.x() = (2*cluster.x()) - k;
            } else {
                newClusterX.x() = k;
            }

            octomap::OcTreeNode* resultX = tree->search(newClusterX); 

            if (resultX != NULL){
                if (!tree->isNodeOccupied(resultX)){
                    selectedClusters.push_back(newClusterX);
                }
            }

            newClusterY.z() = height/2;
            newClusterY.x() = cluster.x();

            float h = ((cluster.z()-(height*0.5))/ 0.36397) + cluster.y();   //divided by tan20 because verticle view angle of kinect is 43 degrees

            if (h > (yn*sideSize*resolution)){
                newClusterY.y() = (2*cluster.y()) - h;
            } else {
                newClusterY.y() = h;
            }

            octomap::OcTreeNode* resultY = tree->search(newClusterY); 

            if (resultY != NULL){
                if (!tree->isNodeOccupied(resultY)){
                    selectedClusters.push_back(newClusterY);
                }
            }
        }
    }
        
    octomap::point3d nearestCluster = selectedClusters[0];

    float min_distance = sqrt(pow(position.x() - nearestCluster.x(), 2) + pow(position.y() - nearestCluster.y(), 2) + pow(position.z() - nearestCluster.z(), 2));

    int lenM = selectedClusters.size();

    for(int i=0; i<lenM; i++){
        octomap::point3d cluster = selectedClusters[i];

        float distance = sqrt(pow(position.x() - cluster.x(), 2) + pow(position.y() - cluster.y(), 2) + pow(position.z() - cluster.z(), 2));

        if (distance<min_distance){
            min_distance = distance;
            nearestCluster = cluster;
        }
    }

    outCluster = nearestCluster;
}

void goal_identifier::calculate(std::vector<octomap::point3d> &centerPointsArray, octomap::point3d &goal){

    ROS_INFO("goal_identifier : started calculating");

    discover_clusters(centerPointsArray);

    ROS_INFO("goal_identifier : created centerpoints array");

    find_nearest_cluster(centerPointsArray, goal);

    ROS_INFO("goal_identifier : completed calculating");
}
