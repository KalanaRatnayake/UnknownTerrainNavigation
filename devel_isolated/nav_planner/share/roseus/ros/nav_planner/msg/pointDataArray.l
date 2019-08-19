;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::pointDataArray)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'pointDataArray (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::POINTDATAARRAY")
  (make-package "NAV_PLANNER::POINTDATAARRAY"))

(in-package "ROS")
;;//! \htmlinclude pointDataArray.msg.html


(defclass nav_planner::pointDataArray
  :super ros::object
  :slots (_centerPointsArray ))

(defmethod nav_planner::pointDataArray
  (:init
   (&key
    ((:centerPointsArray __centerPointsArray) (let (r) (dotimes (i 0) (push (instance nav_planner::pointData :init) r)) r))
    )
   (send-super :init)
   (setq _centerPointsArray __centerPointsArray)
   self)
  (:centerPointsArray
   (&rest __centerPointsArray)
   (if (keywordp (car __centerPointsArray))
       (send* _centerPointsArray __centerPointsArray)
     (progn
       (if __centerPointsArray (setq _centerPointsArray (car __centerPointsArray)))
       _centerPointsArray)))
  (:serialization-length
   ()
   (+
    ;; nav_planner/pointData[] _centerPointsArray
    (apply #'+ (send-all _centerPointsArray :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; nav_planner/pointData[] _centerPointsArray
     (write-long (length _centerPointsArray) s)
     (dolist (elem _centerPointsArray)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; nav_planner/pointData[] _centerPointsArray
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _centerPointsArray (let (r) (dotimes (i n) (push (instance nav_planner::pointData :init) r)) r))
     (dolist (elem- _centerPointsArray)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get nav_planner::pointDataArray :md5sum-) "a6fd97a183dd670c18cc87cf38ec2735")
(setf (get nav_planner::pointDataArray :datatype-) "nav_planner/pointDataArray")
(setf (get nav_planner::pointDataArray :definition-)
      "pointData[] centerPointsArray

================================================================================
MSG: nav_planner/pointData
float32 x
float32 y
float32 z

")



(provide :nav_planner/pointDataArray "a6fd97a183dd670c18cc87cf38ec2735")


