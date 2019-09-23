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
  :slots (_execute ))

(defmethod nav_planner::baseRotateRequest
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

(setf (get nav_planner::baseRotate :md5sum-) "a933da1aed447ccd941e96046fc95d53")
(setf (get nav_planner::baseRotate :datatype-) "nav_planner/baseRotate")
(setf (get nav_planner::baseRotate :request) nav_planner::baseRotateRequest)
(setf (get nav_planner::baseRotate :response) nav_planner::baseRotateResponse)

(defmethod nav_planner::baseRotateRequest
  (:response () (instance nav_planner::baseRotateResponse :init)))

(setf (get nav_planner::baseRotateRequest :md5sum-) "a933da1aed447ccd941e96046fc95d53")
(setf (get nav_planner::baseRotateRequest :datatype-) "nav_planner/baseRotateRequest")
(setf (get nav_planner::baseRotateRequest :definition-)
      "bool execute
---
bool success

")

(setf (get nav_planner::baseRotateResponse :md5sum-) "a933da1aed447ccd941e96046fc95d53")
(setf (get nav_planner::baseRotateResponse :datatype-) "nav_planner/baseRotateResponse")
(setf (get nav_planner::baseRotateResponse :definition-)
      "bool execute
---
bool success

")



(provide :nav_planner/baseRotate "a933da1aed447ccd941e96046fc95d53")


