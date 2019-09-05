;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::mapControl)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'mapControl (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::MAPCONTROL")
  (make-package "NAV_PLANNER::MAPCONTROL"))
(unless (find-package "NAV_PLANNER::MAPCONTROLREQUEST")
  (make-package "NAV_PLANNER::MAPCONTROLREQUEST"))
(unless (find-package "NAV_PLANNER::MAPCONTROLRESPONSE")
  (make-package "NAV_PLANNER::MAPCONTROLRESPONSE"))

(in-package "ROS")





(defclass nav_planner::mapControlRequest
  :super ros::object
  :slots (_requestTree ))

(defmethod nav_planner::mapControlRequest
  (:init
   (&key
    ((:requestTree __requestTree) nil)
    )
   (send-super :init)
   (setq _requestTree __requestTree)
   self)
  (:requestTree
   (&optional __requestTree)
   (if __requestTree (setq _requestTree __requestTree)) _requestTree)
  (:serialization-length
   ()
   (+
    ;; bool _requestTree
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _requestTree
       (if _requestTree (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _requestTree
     (setq _requestTree (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass nav_planner::mapControlResponse
  :super ros::object
  :slots (_success ))

(defmethod nav_planner::mapControlResponse
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

(defclass nav_planner::mapControl
  :super ros::object
  :slots ())

(setf (get nav_planner::mapControl :md5sum-) "a2ef632b8b905476992515bef0f3da16")
(setf (get nav_planner::mapControl :datatype-) "nav_planner/mapControl")
(setf (get nav_planner::mapControl :request) nav_planner::mapControlRequest)
(setf (get nav_planner::mapControl :response) nav_planner::mapControlResponse)

(defmethod nav_planner::mapControlRequest
  (:response () (instance nav_planner::mapControlResponse :init)))

(setf (get nav_planner::mapControlRequest :md5sum-) "a2ef632b8b905476992515bef0f3da16")
(setf (get nav_planner::mapControlRequest :datatype-) "nav_planner/mapControlRequest")
(setf (get nav_planner::mapControlRequest :definition-)
      "bool requestTree
---
bool success

")

(setf (get nav_planner::mapControlResponse :md5sum-) "a2ef632b8b905476992515bef0f3da16")
(setf (get nav_planner::mapControlResponse :datatype-) "nav_planner/mapControlResponse")
(setf (get nav_planner::mapControlResponse :definition-)
      "bool requestTree
---
bool success

")



(provide :nav_planner/mapControl "a2ef632b8b905476992515bef0f3da16")


