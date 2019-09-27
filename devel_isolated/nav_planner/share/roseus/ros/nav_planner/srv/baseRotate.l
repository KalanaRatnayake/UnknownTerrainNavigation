;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::baseRotate)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'baseRotate (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::BASEROTATE")
  (make-package "NAV_PLANNER::BASEROTATE"))
(unless (find-package "NAV_PLANNER::BASEROTATEREQUEST")
  (make-package "NAV_PLANNER::BASEROTATEREQUEST"))
(unless (find-package "NAV_PLANNER::BASEROTATERESPONSE")
  (make-package "NAV_PLANNER::BASEROTATERESPONSE"))

(in-package "ROS")





(defclass nav_planner::baseRotateRequest
  :super ros::object
  :slots (_angle ))

(defmethod nav_planner::baseRotateRequest
  (:init
   (&key
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _angle (float __angle))
   self)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; float64 _angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _angle
     (setq _angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass nav_planner::baseRotateResponse
  :super ros::object
  :slots (_success ))

(defmethod nav_planner::baseRotateResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass nav_planner::baseRotate
  :super ros::object
  :slots ())

(setf (get nav_planner::baseRotate :md5sum-) "c1a76fcaf62dc4534903e93216b59a79")
(setf (get nav_planner::baseRotate :datatype-) "nav_planner/baseRotate")
(setf (get nav_planner::baseRotate :request) nav_planner::baseRotateRequest)
(setf (get nav_planner::baseRotate :response) nav_planner::baseRotateResponse)

(defmethod nav_planner::baseRotateRequest
  (:response () (instance nav_planner::baseRotateResponse :init)))

(setf (get nav_planner::baseRotateRequest :md5sum-) "c1a76fcaf62dc4534903e93216b59a79")
(setf (get nav_planner::baseRotateRequest :datatype-) "nav_planner/baseRotateRequest")
(setf (get nav_planner::baseRotateRequest :definition-)
      "float64 angle
---
bool success

")

(setf (get nav_planner::baseRotateResponse :md5sum-) "c1a76fcaf62dc4534903e93216b59a79")
(setf (get nav_planner::baseRotateResponse :datatype-) "nav_planner/baseRotateResponse")
(setf (get nav_planner::baseRotateResponse :definition-)
      "float64 angle
---
bool success

")



(provide :nav_planner/baseRotate "c1a76fcaf62dc4534903e93216b59a79")


