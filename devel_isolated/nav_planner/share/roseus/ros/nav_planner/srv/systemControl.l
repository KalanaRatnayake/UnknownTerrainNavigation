;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::systemControl)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'systemControl (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::SYSTEMCONTROL")
  (make-package "NAV_PLANNER::SYSTEMCONTROL"))
(unless (find-package "NAV_PLANNER::SYSTEMCONTROLREQUEST")
  (make-package "NAV_PLANNER::SYSTEMCONTROLREQUEST"))
(unless (find-package "NAV_PLANNER::SYSTEMCONTROLRESPONSE")
  (make-package "NAV_PLANNER::SYSTEMCONTROLRESPONSE"))

(in-package "ROS")





(defclass nav_planner::systemControlRequest
  :super ros::object
  :slots (_activate ))

(defmethod nav_planner::systemControlRequest
  (:init
   (&key
    ((:activate __activate) nil)
    )
   (send-super :init)
   (setq _activate __activate)
   self)
  (:activate
   (&optional __activate)
   (if __activate (setq _activate __activate)) _activate)
  (:serialization-length
   ()
   (+
    ;; bool _activate
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _activate
       (if _activate (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _activate
     (setq _activate (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass nav_planner::systemControlResponse
  :super ros::object
  :slots (_success ))

(defmethod nav_planner::systemControlResponse
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

(defclass nav_planner::systemControl
  :super ros::object
  :slots ())

(setf (get nav_planner::systemControl :md5sum-) "28dadd83d564c0f1c7317577c2a315b5")
(setf (get nav_planner::systemControl :datatype-) "nav_planner/systemControl")
(setf (get nav_planner::systemControl :request) nav_planner::systemControlRequest)
(setf (get nav_planner::systemControl :response) nav_planner::systemControlResponse)

(defmethod nav_planner::systemControlRequest
  (:response () (instance nav_planner::systemControlResponse :init)))

(setf (get nav_planner::systemControlRequest :md5sum-) "28dadd83d564c0f1c7317577c2a315b5")
(setf (get nav_planner::systemControlRequest :datatype-) "nav_planner/systemControlRequest")
(setf (get nav_planner::systemControlRequest :definition-)
      "bool activate
---
bool success

")

(setf (get nav_planner::systemControlResponse :md5sum-) "28dadd83d564c0f1c7317577c2a315b5")
(setf (get nav_planner::systemControlResponse :datatype-) "nav_planner/systemControlResponse")
(setf (get nav_planner::systemControlResponse :definition-)
      "bool activate
---
bool success

")



(provide :nav_planner/systemControl "28dadd83d564c0f1c7317577c2a315b5")


