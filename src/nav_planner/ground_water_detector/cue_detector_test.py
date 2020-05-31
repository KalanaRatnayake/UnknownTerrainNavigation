import cv2
import numpy as np

def varianceFilter(image, filterSize):
    wmean, wsqrmean = (cv2.boxFilter(x, -1, (filterSize, filterSize), borderType=cv2.BORDER_REFLECT) for x in (image, image*image))
    return wsqrmean - wmean*wmean

def findInflectionPoints(points):
    shape = points.shape
    x = np.array([i for i in range(1, shape[0])])

    d = np.diff(points)
    mask = d[:-1]*d[1:] > 0

    return x[mask]

def removeSmallRegionsMask (mask, filterSize):
    mask = mask.astype(np.uint8)*255
    kernel = np.ones((filterSize,filterSize),np.uint8)
    mask = cv2.erode(mask, kernel, iterations = 1)
    mask = mask.astype(np.bool)
    return mask

def addSmallRegionsMask (mask, filterSize):
    mask = mask.astype(np.uint8)*255
    kernel = np.ones((filterSize,filterSize),np.uint8)
    mask = cv2.dilate(mask, kernel, iterations = 1)
    mask = mask.astype(np.bool)
    return mask

def cueColor(image):
    processed = image.copy()
    
    conv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    h = conv_image[:, :, 0]
    s = conv_image[:, :, 1]
    b = conv_image[:, :, 2]

    condition_1 = (s == 0)
    condition_2 = (s <= 64) & (b >= 192)

    result = np.logical_or(condition_1, condition_2)

    sky = np.any((b[0:10, :] >= 220) & (s[0:10, :] <= 30))

    if sky:
        condition_3 = (s <= 25) & (b >= 180)
        condition_4 = (s <= 75) & (b >= 180) & (h>240) & (h<285)

        result2 = np.logical_or(condition_3, condition_4)
        final = np.logical_or(result, result2)
    else:
        final = result

    final = removeSmallRegionsMask(final, 4)

    return final

def cueTexture(image):
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    h = hsv[ :, :, 0]
    s = hsv[ :, :, 1]
    v = hsv[ :, :, 2]
    g = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    filtered_g = varianceFilter(g, 9)
    filtered_s = varianceFilter(s, 9)

    condition_5 = filtered_g < 25
    condition_6 = filtered_s < 25

    condition_7g = (v > 75)
    condition_8g = (s <= 154) | (v >= 64) | ((s-v) <= 77)

    maskTempG = np.logical_or(condition_7g, condition_8g)

    condition_7s = (s > 10) & (s < 175)
    condition_8s = (s <= 154) | (v >= 64) | ((s-v) <= 26) | ((s <= 154) & (v >= 220)) | (v==255)

    maskTempS = np.logical_or(condition_7s, condition_8s)

    maskG = np.logical_and(condition_5, maskTempG)
    maskS = np.logical_and(condition_6, maskTempS)

    mask = np.logical_or(maskG, maskS)

    mask = addSmallRegionsMask(mask, 7)

    return mask

def cueRangeRefleection(depthImage):
    shape = depthImage.shape
    mask = np.full(shape, False, bool)

    for i in range(shape[1]):  #iterate through columns
        points = findInflectionPoints(depthImage[:, i])
        if points.shape[0]>0:
            val = points.shape[0]
            
            for j in range(val/2):
                mask[points[2*j]:points[(2*j)+1], i] = True 

            if bool(val%2):
                mask[points[-1]:255, i] = True
    
    mask = removeSmallRegionsMask(mask, 9)
    return mask

def check(image, depthImage):
    maskColor = cueColor(image)
    maskTexture = cueTexture(image)
    maskRReflection = cueRangeReflection(depthImage)

    mask1 = maskRReflection
    mask2 = np.logical_not(maskRReflection) & maskColor & maskTexture

    return (mask1 | mask2)
  
# Using cv2.imread() method 
img = cv2.imread("/home/kalana/FYP/src/nav_planner/ground_water_detector/test_images/11.jpg")

maskColor = cueColor(img)
maskTextu = cueTexture(img)

mask = maskColor & maskTextu

img[mask] = (255, 0, 0)
  
# Displaying the image 
cv2.imwrite("/home/kalana/FYP/src/nav_planner/ground_water_detector/test_images/11_test.jpg", img) 