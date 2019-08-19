;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::goalControl)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'goalControl (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::GOALCONTROL")
  (make-package "NAV_PLANNER::GOALCONTROL"))
(unless (find-package "NAV_PLANNER::GOALCONTROLREQUEST")
  (make-package "NAV_PLANNER::GOALCONTROLREQUEST"))
(unless (find-package "NAV_PLANNER::GOALCONTROLRESPONSE")
  (make-package "NAV_PLANNER::GOALCONTROLRESPONSE"))

(in-package "ROS")





(defclass nav_planner::goalControlRequest
  :super ros::object
  :slots (_execute ))

(defmethod nav_planner::goalControlRequest
  (:init
   (&key
    ((:execute __execute) nil)
    )
   (send-super :init)
   (setq _execute __execute)
   self)
  (:execute
   (&optional __execute)
   (if __execute (setq _execute __execute)) _execute)
  (:serialization-length
   ()
   (+
    ;; bool _execute
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _execute
       (if _execute (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _execute
     (setq _execute (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass nav_planner::goalControlResponse
  :super ros::object
  :slots (_x _y _z ))

(defmethod nav_planner::goalControlResponse
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _z
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass nav_planner::goalControl
  :super ros::object
  :slots ())

(setf (get nav_planner::goalControl :md5sum-) "4264199fe659d58fcdd2ad61fb4fcaec")
(setf (get nav_planner::goalControl :datatype-) "nav_planner/goalControl")
(setf (get nav_planner::goalControl :request) nav_planner::goalControlRequest)
(setf (get nav_planner::goalControl :response) nav_planner::goalControlResponse)

(defmethod nav_planner::goalControlRequest
  (:response () (instance nav_planner::goalControlResponse :init)))

(setf (get nav_planner::goalControlRequest :md5sum-) "4264199fe659d58fcdd2ad61fb4fcaec")
(setf (get nav_planner::goalControlRequest :datatype-) "nav_planner/goalControlRequest")
(setf (get nav_planner::goalControlRequest :definition-)
      "bool execute
---
float32 x
float32 y
float32 z

")

(setf (get nav_planner::goalControlResponse :md5sum-) "4264199fe659d58fcdd2ad61fb4fcaec")
(setf (get nav_planner::goalControlResponse :datatype-) "nav_planner/goalControlResponse")
(setf (get nav_planner::goalControlResponse :definition-)
      "bool execute
---
float32 x
float32 y
float32 z

")



(provide :nav_planner/goalControl "4264199fe659d58fcdd2ad61fb4fcaec")


