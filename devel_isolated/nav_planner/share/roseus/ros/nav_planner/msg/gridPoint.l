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
  :slots (_init _proc _path ))

(defmethod nav_planner::gridPoint
  (:init
   (&key
    ((:init __init) 0)
    ((:proc __proc) 0)
    ((:path __path) 0)
    )
   (send-super :init)
   (setq _init (round __init))
   (setq _proc (round __proc))
   (setq _path (round __path))
   self)
  (:init
   (&optional __init)
   (if __init (setq _init __init)) _init)
  (:proc
   (&optional __proc)
   (if __proc (setq _proc __proc)) _proc)
  (:path
   (&optional __path)
   (if __path (setq _path __path)) _path)
  (:serialization-length
   ()
   (+
    ;; int8 _init
    1
    ;; int8 _proc
    1
    ;; int8 _path
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
     ;; int8 _path
       (write-byte _path s)
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
   ;; int8 _path
     (setq _path (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _path 127) (setq _path (- _path 256)))
   ;;
   self)
  )

(setf (get nav_planner::gridPoint :md5sum-) "6473cd93ef160624bb8e42a565e25ccb")
(setf (get nav_planner::gridPoint :datatype-) "nav_planner/gridPoint")
(setf (get nav_planner::gridPoint :definition-)
      "int8 init
int8 proc
int8 path
")



(provide :nav_planner/gridPoint "6473cd93ef160624bb8e42a565e25ccb")


