;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::goalRemove)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'goalRemove (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::GOALREMOVE")
  (make-package "NAV_PLANNER::GOALREMOVE"))
(unless (find-package "NAV_PLANNER::GOALREMOVEREQUEST")
  (make-package "NAV_PLANNER::GOALREMOVEREQUEST"))
(unless (find-package "NAV_PLANNER::GOALREMOVERESPONSE")
  (make-package "NAV_PLANNER::GOALREMOVERESPONSE"))

(in-package "ROS")





(defclass nav_planner::goalRemoveRequest
  :super ros::object
  :slots (_x _y _z ))

(defmethod nav_planner::goalRemoveRequest
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

(defclass nav_planner::goalRemoveResponse
  :super ros::object
  :slots (_success ))

(defmethod nav_planner::goalRemoveResponse
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

(defclass nav_planner::goalRemove
  :super ros::object
  :slots ())

(setf (get nav_planner::goalRemove :md5sum-) "58d59f258ca9f2d2ba375d9428a7f1de")
(setf (get nav_planner::goalRemove :datatype-) "nav_planner/goalRemove")
(setf (get nav_planner::goalRemove :request) nav_planner::goalRemoveRequest)
(setf (get nav_planner::goalRemove :response) nav_planner::goalRemoveResponse)

(defmethod nav_planner::goalRemoveRequest
  (:response () (instance nav_planner::goalRemoveResponse :init)))

(setf (get nav_planner::goalRemoveRequest :md5sum-) "58d59f258ca9f2d2ba375d9428a7f1de")
(setf (get nav_planner::goalRemoveRequest :datatype-) "nav_planner/goalRemoveRequest")
(setf (get nav_planner::goalRemoveRequest :definition-)
      "float32 x
float32 y
float32 z
---
bool success

")

(setf (get nav_planner::goalRemoveResponse :md5sum-) "58d59f258ca9f2d2ba375d9428a7f1de")
(setf (get nav_planner::goalRemoveResponse :datatype-) "nav_planner/goalRemoveResponse")
(setf (get nav_planner::goalRemoveResponse :definition-)
      "float32 x
float32 y
float32 z
---
bool success

")



(provide :nav_planner/goalRemove "58d59f258ca9f2d2ba375d9428a7f1de")


