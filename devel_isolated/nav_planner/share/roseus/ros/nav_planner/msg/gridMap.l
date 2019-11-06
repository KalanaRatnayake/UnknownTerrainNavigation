;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::gridMap)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'gridMap (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::GRIDMAP")
  (make-package "NAV_PLANNER::GRIDMAP"))

(in-package "ROS")
;;//! \htmlinclude gridMap.msg.html


(defclass nav_planner::gridMap
  :super ros::object
  :slots (_grid _path _pathLength ))

(defmethod nav_planner::gridMap
  (:init
   (&key
    ((:grid __grid) (let (r) (dotimes (i 0) (push (instance nav_planner::gridRow :init) r)) r))
    ((:path __path) (let (r) (dotimes (i 0) (push (instance nav_planner::pointData :init) r)) r))
    ((:pathLength __pathLength) 0)
    )
   (send-super :init)
   (setq _grid __grid)
   (setq _path __path)
   (setq _pathLength (round __pathLength))
   self)
  (:grid
   (&rest __grid)
   (if (keywordp (car __grid))
       (send* _grid __grid)
     (progn
       (if __grid (setq _grid (car __grid)))
       _grid)))
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:pathLength
   (&optional __pathLength)
   (if __pathLength (setq _pathLength __pathLength)) _pathLength)
  (:serialization-length
   ()
   (+
    ;; nav_planner/gridRow[] _grid
    (apply #'+ (send-all _grid :serialization-length)) 4
    ;; nav_planner/pointData[] _path
    (apply #'+ (send-all _path :serialization-length)) 4
    ;; int16 _pathLength
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; nav_planner/gridRow[] _grid
     (write-long (length _grid) s)
     (dolist (elem _grid)
       (send elem :serialize s)
       )
     ;; nav_planner/pointData[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (send elem :serialize s)
       )
     ;; int16 _pathLength
       (write-word _pathLength s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; nav_planner/gridRow[] _grid
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _grid (let (r) (dotimes (i n) (push (instance nav_planner::gridRow :init) r)) r))
     (dolist (elem- _grid)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; nav_planner/pointData[] _path
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _path (let (r) (dotimes (i n) (push (instance nav_planner::pointData :init) r)) r))
     (dolist (elem- _path)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int16 _pathLength
     (setq _pathLength (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get nav_planner::gridMap :md5sum-) "1e2dc952130c008ed024ffc4c0c5cfad")
(setf (get nav_planner::gridMap :datatype-) "nav_planner/gridMap")
(setf (get nav_planner::gridMap :definition-)
      "gridRow[] grid
pointData[] path
int16 pathLength
================================================================================
MSG: nav_planner/gridRow
gridPoint[] row

================================================================================
MSG: nav_planner/gridPoint
int8 init
int8 proc
int8 disc
================================================================================
MSG: nav_planner/pointData
float32 x
float32 y
float32 z

")



(provide :nav_planner/gridMap "1e2dc952130c008ed024ffc4c0c5cfad")


