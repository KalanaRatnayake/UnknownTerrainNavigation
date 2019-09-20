;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::waterDetect)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'waterDetect (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::WATERDETECT")
  (make-package "NAV_PLANNER::WATERDETECT"))
(unless (find-package "NAV_PLANNER::WATERDETECTREQUEST")
  (make-package "NAV_PLANNER::WATERDETECTREQUEST"))
(unless (find-package "NAV_PLANNER::WATERDETECTRESPONSE")
  (make-package "NAV_PLANNER::WATERDETECTRESPONSE"))

(in-package "ROS")





(defclass nav_planner::waterDetectRequest
  :super ros::object
  :slots (_detect ))

(defmethod nav_planner::waterDetectRequest
  (:init
   (&key
    ((:detect __detect) nil)
    )
   (send-super :init)
   (setq _detect __detect)
   self)
  (:detect
   (&optional __detect)
   (if __detect (setq _detect __detect)) _detect)
  (:serialization-length
   ()
   (+
    ;; bool _detect
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _detect
       (if _detect (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _detect
     (setq _detect (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass nav_planner::waterDetectResponse
  :super ros::object
  :slots (_left _middle _right ))

(defmethod nav_planner::waterDetectResponse
  (:init
   (&key
    ((:left __left) 0.0)
    ((:middle __middle) 0.0)
    ((:right __right) 0.0)
    )
   (send-super :init)
   (setq _left (float __left))
   (setq _middle (float __middle))
   (setq _right (float __right))
   self)
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:middle
   (&optional __middle)
   (if __middle (setq _middle __middle)) _middle)
  (:right
   (&optional __right)
   (if __right (setq _right __right)) _right)
  (:serialization-length
   ()
   (+
    ;; float32 _left
    4
    ;; float32 _middle
    4
    ;; float32 _right
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _left
       (sys::poke _left (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _middle
       (sys::poke _middle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _right
       (sys::poke _right (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _left
     (setq _left (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _middle
     (setq _middle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _right
     (setq _right (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass nav_planner::waterDetect
  :super ros::object
  :slots ())

(setf (get nav_planner::waterDetect :md5sum-) "1db7aa6468aac5d9a2abbc22f9783ea6")
(setf (get nav_planner::waterDetect :datatype-) "nav_planner/waterDetect")
(setf (get nav_planner::waterDetect :request) nav_planner::waterDetectRequest)
(setf (get nav_planner::waterDetect :response) nav_planner::waterDetectResponse)

(defmethod nav_planner::waterDetectRequest
  (:response () (instance nav_planner::waterDetectResponse :init)))

(setf (get nav_planner::waterDetectRequest :md5sum-) "1db7aa6468aac5d9a2abbc22f9783ea6")
(setf (get nav_planner::waterDetectRequest :datatype-) "nav_planner/waterDetectRequest")
(setf (get nav_planner::waterDetectRequest :definition-)
      "bool detect
---
float32 left
float32 middle
float32 right

")

(setf (get nav_planner::waterDetectResponse :md5sum-) "1db7aa6468aac5d9a2abbc22f9783ea6")
(setf (get nav_planner::waterDetectResponse :datatype-) "nav_planner/waterDetectResponse")
(setf (get nav_planner::waterDetectResponse :definition-)
      "bool detect
---
float32 left
float32 middle
float32 right

")



(provide :nav_planner/waterDetect "1db7aa6468aac5d9a2abbc22f9783ea6")


