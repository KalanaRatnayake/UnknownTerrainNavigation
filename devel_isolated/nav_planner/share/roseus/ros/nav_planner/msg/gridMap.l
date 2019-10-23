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
  :slots (_grid ))

(defmethod nav_planner::gridMap
  (:init
   (&key
    ((:grid __grid) (let (r) (dotimes (i 0) (push (instance nav_planner::gridRow :init) r)) r))
    )
   (send-super :init)
   (setq _grid __grid)
   self)
  (:grid
   (&rest __grid)
   (if (keywordp (car __grid))
       (send* _grid __grid)
     (progn
       (if __grid (setq _grid (car __grid)))
       _grid)))
  (:serialization-length
   ()
   (+
    ;; nav_planner/gridRow[] _grid
    (apply #'+ (send-all _grid :serialization-length)) 4
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
   ;;
   self)
  )

(setf (get nav_planner::gridMap :md5sum-) "871833bd332a580973308691ab02d68a")
(setf (get nav_planner::gridMap :datatype-) "nav_planner/gridMap")
(setf (get nav_planner::gridMap :definition-)
      "gridRow[] grid

================================================================================
MSG: nav_planner/gridRow
gridPoint[] row

================================================================================
MSG: nav_planner/gridPoint
int8 init
int8 proc
int8 path
")



(provide :nav_planner/gridMap "871833bd332a580973308691ab02d68a")


