#!/usr/bin/env python

import rospy
import numpy as np
import cv2
from nav_planner.msg import gridMap, gridRow, gridPoint

ROW = 400 
COL = 400
index = 1
initlock = False
proclock = False
pathlock = False

grid = np.zeros([ROW, COL, 3], np.int8)

# Description of the Grid- {1--> not occupied} {0--> occupied} 

def save():
    name = "/FYP/src/nav_planner/grid_Images/"+ str(index) +".jpg"
    cv2.imwrite(name, grid)
    index += 1

def callbackGrid(msg):
    for i in range(0, ROW):
        array = msg.grid[i]

        for j in range (0, COL):
            point = array.row[j]

            #initial grid is saved as BLUE channel
            if (point.init==0):
                grid[i][j][0] = 255

            #processed grid (with padding) is saved as GREEN channel
            if (point.proc==0):
                grid[i][j][1] = 255

            #path is saved as RED channel
            if (point.path==0):
                grid[i][j][2] = 255
                
    save()

    
def grid_image_creator():
    rospy.init_node('Grid_Image_Creator')

    rospy.Subscriber("grid", gridMap, callbackGrid)

    rospy.spin()

if __name__ == '__main__':
    grid_image_creator()