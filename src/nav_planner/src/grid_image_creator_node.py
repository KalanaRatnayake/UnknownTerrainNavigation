#!/usr/bin/env python

import rospy
import numpy as np
import cv2
from nav_planner.msg import gridMap, gridRow, gridPoint
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

ROW = 400 
COL = 400
index = 1
initlock = False
proclock = False
pathlock = False

class grid_image_creator:

    # Description of the Grid- {1--> not occupied} {0--> occupied} 

    def __init__(self):
        self.image_pub = rospy.Publisher("gridMap",Image)
        self.gridM_sub = rospy.Subscriber("grid", gridMap, self.callbackGrid)
        self.bridge = CvBridge()

    def callbackGrid(self, msg):
        grid = np.zeros([ROW, COL, 3], np.int8)

        for i in range(0, ROW):
            array = msg.grid[i]

            for j in range (0, COL):
                point = array.row[j]

                #initial grid is saved as BLUE channel
                if (point.init==0):
                    self.grid[i][j][0] = 255

                #processed grid (with padding) is saved as GREEN channel
                if (point.proc==0):
                    self.grid[i][j][1] = 255

                #path is saved as RED channel
                if (point.path==0):
                    self.grid[i][j][2] = 255
                    
        name = "/FYP/src/nav_planner/grid_Images/"+ str(index) +".jpg"
        cv2.imwrite(name, self.grid)
        index += 1

        try:
            self.image_pub.publish(self.bridge.cv2_to_imgmsg(grid, "bgr8"))
        except CvBridgeError as e:
            print(e)

        
def main():
    creator = grid_image_creator()
    rospy.init_node('Grid_Image_Creator')
    rospy.spin()

if __name__ == '__main__':
    main()