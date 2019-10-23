;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::mapSave)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'mapSave (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::MAPSAVE")
  (make-package "NAV_PLANNER::MAPSAVE"))
(unless (find-package "NAV_PLANNER::MAPSAVEREQUEST")
  (make-package "NAV_PLANNER::MAPSAVEREQUEST"))
(unless (find-package "NAV_PLANNER::MAPSAVERESPONSE")
  (make-package "NAV_PLANNER::MAPSAVERESPONSE"))

(in-package "ROS")





(defclass nav_planner::mapSaveRequest
  :super ros::object
  :slots (_save ))

(defmethod nav_planner::mapSaveRequest
  (:init
   (&key
    ((:save __save) nil)
    )
   (send-super :init)
   (setq _save __save)
   self)
  (:save
   (&optional __save)
   (if __save (setq _save __save)) _save)
  (:serialization-length
   ()
   (+
    ;; bool _save
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _save
       (if _save (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _save
     (setq _save (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass nav_planner::mapSaveResponse
  :super ros::object
  :slots (_success ))

(defmethod nav_planner::mapSaveResponse
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

(defclass nav_planner::mapSave
  :super ros::object
  :slots ())

(setf (get nav_planner::mapSave :md5sum-) "f6ec99713685605bc49d86e471c42eb7")
(setf (get nav_planner::mapSave :datatype-) "nav_planner/mapSave")
(setf (get nav_planner::mapSave :request) nav_planner::mapSaveRequest)
(setf (get nav_planner::mapSave :response) nav_planner::mapSaveResponse)

(defmethod nav_planner::mapSaveRequest
  (:response () (instance nav_planner::mapSaveResponse :init)))

(setf (get nav_planner::mapSaveRequest :md5sum-) "f6ec99713685605bc49d86e471c42eb7")
(setf (get nav_planner::mapSaveRequest :datatype-) "nav_planner/mapSaveRequest")
(setf (get nav_planner::mapSaveRequest :definition-)
      "bool save
---
bool success

")

(setf (get nav_planner::mapSaveResponse :md5sum-) "f6ec99713685605bc49d86e471c42eb7")
(setf (get nav_planner::mapSaveResponse :datatype-) "nav_planner/mapSaveResponse")
(setf (get nav_planner::mapSaveResponse :definition-)
      "bool save
---
bool success

")



(provide :nav_planner/mapSave "f6ec99713685605bc49d86e471c42eb7")


