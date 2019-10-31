;; Auto-generated. Do not edit!


(when (boundp 'nav_planner::gridRow)
  (if (not (find-package "NAV_PLANNER"))
    (make-package "NAV_PLANNER"))
  (shadow 'gridRow (find-package "NAV_PLANNER")))
(unless (find-package "NAV_PLANNER::GRIDROW")
  (make-package "NAV_PLANNER::GRIDROW"))

(in-package "ROS")
;;//! \htmlinclude gridRow.msg.html


(defclass nav_planner::gridRow
  :super ros::object
  :slots (_row ))

(defmethod nav_planner::gridRow
  (:init
   (&key
    ((:row __row) (let (r) (dotimes (i 0) (push (instance nav_planner::gridPoint :init) r)) r))
    )
   (send-super :init)
   (setq _row __row)
   self)
  (:row
   (&rest __row)
   (if (keywordp (car __row))
       (send* _row __row)
     (progn
       (if __row (setq _row (car __row)))
       _row)))
  (:serialization-length
   ()
   (+
    ;; nav_planner/gridPoint[] _row
    (apply #'+ (send-all _row :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; nav_planner/gridPoint[] _row
     (write-long (length _row) s)
     (dolist (elem _row)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; nav_planner/gridPoint[] _row
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _row (let (r) (dotimes (i n) (push (instance nav_planner::gridPoint :init) r)) r))
     (dolist (elem- _row)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get nav_planner::gridRow :md5sum-) "b79fca104e1ff6a6b0cdcd662d07d607")
(setf (get nav_planner::gridRow :datatype-) "nav_planner/gridRow")
(setf (get nav_planner::gridRow :definition-)
      "gridPoint[] row

================================================================================
MSG: nav_planner/gridPoint
int8 init
int8 proc
")



(provide :nav_planner/gridRow "b79fca104e1ff6a6b0cdcd662d07d607")


