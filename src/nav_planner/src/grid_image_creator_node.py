#!/usr/bin/env python

import rospy
import numpy as np
import cv2
from nav_planner.msg import gridMap, gridRow, gridPoint
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

class grid_image_creator:

    # Description of the Grid- {1--> not occupied} {0--> occupied} 

    def __init__(self):
        self.image_pub = rospy.Publisher("gridMap",Image, queue_size=1, latch=True)
        self.gridM_sub = rospy.Subscriber("grid", gridMap, self.callbackGrid)
        self.bridge = CvBridge()
        self.index = 1
        self.ROW = 800
        self.COL = 800

    def callbackGrid(self, msg):
        gridImage = np.zeros([self.ROW, self.COL, 3], np.uint8)
        path = []

        for i in range(0, self.ROW):
            array = msg.grid[i]

            for j in range (0, self.COL):
                point = array.row[j]
                #initial grid is saved as BLUE channel
                if (point.init==0):
                    gridImage[i][j][0] = 255

                #processed grid (with padding) is saved as GREEN channel
                if (point.proc==0):
                    gridImage[i][j][1] = 255

                #path is saved as RED channel
                if (point.path==0):
                    path.append([i, j])
                    print(i)
                    print(j)

        for k in range(0, (len(path)-1)):
            cv2.line(gridImage, (path[k][0], path[k][1]), (path[k+1][0], path[k+1][1]), (0,0,255), 2)


        try:
            self.image_pub.publish(self.bridge.cv2_to_imgmsg(gridImage, "bgr8"))
            
            name = str(self.index) +".jpeg"
            outImage = cv2.cvtColor(gridImage, cv2.COLOR_BGR2RGB)
            cv2.imwrite(name, gridImage)
            self.index += 1

        except CvBridgeError as e:
            print(e)

        
def main():
    creator = grid_image_creator()
    rospy.init_node('Grid_Image_Creator')
    rospy.spin()

if __name__ == '__main__':
    main()