#!/usr/bin/env python

import sys
import rospy
from waterDetect.srv import waterDetect

def checkWater(x, y):
    rospy.wait_for_service('water_detect_service')
    try:
        detectWater = rospy.ServiceProxy('water_detect_service', waterDetect)
        response = detectWater(True)
        return response.left, response.middle, response.right
    except rospy.ServiceException, e:
        print "Service call failed: %s"%e

if __name__ == "__main__":
    print "Requesting water detect service
    print "%s" %(add_two_ints_client(x, y))