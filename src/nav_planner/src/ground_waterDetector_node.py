from __future__ import print_function

import rospy
import roslib
roslib.load_manifest('my_package')
import cv2
from waterDetect.srv import waterDetect, waterDetectResponse
from cue_detector import analyze
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError 

class image_analyzer:

    def __init__(self):
        self.image = None
        self.depthMap = None

        self.bridge = CvBridge()

        self.image_sub = rospy.Subscriber("image", Image, self.callbackImage)
        self.depth_sub = rospy.Subscriber("depth", Image, self.callbackDepthMap)

        self.waterDSer = rospy.Service('detectWater', waterDetect, self.waterDetect_response)
 
    def callbackImage(self,data):
        try:
            self.image = self.bridge.imgmsg_to_cv2(data, "bgr8")
        except CvBridgeError as e:
            print(e)

    def callbackDepthMap(self,data):
        try:
            self.depthMap = self.bridge.imgmsg_to_cv2(data, "mono8")
        except CvBridgeError as e:
            print(e)

    def waterDetect_response(self,request):
        left, middle, right = analyze(self.image, self.depthMap)

        return waterDetectResponse(left=left, middle=middle, right=right)


def main():
    analyzer = image_analyzer()
    rospy.init_node('water_detect_service')
    rospy.spin()


if __name__ == '__main__':
    main()