;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::gridPoint)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'gridPoint (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::GRIDPOINT")
  (make-package "NAV_PLANNER::GRIDPOINT"))

(in-package "ROS")
;;//! \htmlinclude gridPoint.msg.html


(defclass nav_planner::gridPoint
  :super ros::object
  :slots (_init _proc _disc ))

(defmethod nav_planner::gridPoint
  (:init
   (&key
    ((:init __init) 0)
    ((:proc __proc) 0)
    ((:disc __disc) 0)
    )
   (send-super :init)
   (setq _init (round __init))
   (setq _proc (round __proc))
   (setq _disc (round __disc))
   self)
  (:init
   (&optional __init)
   (if __init (setq _init __init)) _init)
  (:proc
   (&optional __proc)
   (if __proc (setq _proc __proc)) _proc)
  (:disc
   (&optional __disc)
   (if __disc (setq _disc __disc)) _disc)
  (:serialization-length
   ()
   (+
    ;; int8 _init
    1
    ;; int8 _proc
    1
    ;; int8 _disc
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _init
       (write-byte _init s)
     ;; int8 _proc
       (write-byte _proc s)
     ;; int8 _disc
       (write-byte _disc s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _init
     (setq _init (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _init 127) (setq _init (- _init 256)))
   ;; int8 _proc
     (setq _proc (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _proc 127) (setq _proc (- _proc 256)))
   ;; int8 _disc
     (setq _disc (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _disc 127) (setq _disc (- _disc 256)))
   ;;
   self)
  )

(setf (get nav_planner::gridPoint :md5sum-) "9c89479da1035ab9eb04a27d7e072480")
(setf (get nav_planner::gridPoint :datatype-) "nav_planner/gridPoint")
(setf (get nav_planner::gridPoint :definition-)
      "int8 init
int8 proc
int8 disc
")



(provide :nav_planner/gridPoint "9c89479da1035ab9eb04a27d7e072480")


