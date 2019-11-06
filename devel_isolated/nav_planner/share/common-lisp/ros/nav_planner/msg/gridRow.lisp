; Auto-generated. Do not edit!


(cl:in-package nav_planner-msg)


;//! \htmlinclude gridRow.msg.html

(cl:defclass <gridRow> (roslisp-msg-protocol:ros-message)
  ((row
    :reader row
    :initarg :row
    :type (cl:vector nav_planner-msg:gridPoint)
   :initform (cl:make-array 0 :element-type 'nav_planner-msg:gridPoint :initial-element (cl:make-instance 'nav_planner-msg:gridPoint))))
)

(cl:defclass gridRow (<gridRow>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gridRow>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gridRow)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-msg:<gridRow> is deprecated: use nav_planner-msg:gridRow instead.")))

(cl:ensure-generic-function 'row-val :lambda-list '(m))
(cl:defmethod row-val ((m <gridRow>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:row-val is deprecated.  Use nav_planner-msg:row instead.")
  (row m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gridRow>) ostream)
  "Serializes a message object of type '<gridRow>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'row))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'row))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gridRow>) istream)
  "Deserializes a message object of type '<gridRow>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'row) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'row)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'nav_planner-msg:gridPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gridRow>)))
  "Returns string type for a message object of type '<gridRow>"
  "nav_planner/gridRow")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gridRow)))
  "Returns string type for a message object of type 'gridRow"
  "nav_planner/gridRow")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gridRow>)))
  "Returns md5sum for a message object of type '<gridRow>"
  "4077bd51d2ef02451e7ce2c5b9ff044d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gridRow)))
  "Returns md5sum for a message object of type 'gridRow"
  "4077bd51d2ef02451e7ce2c5b9ff044d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gridRow>)))
  "Returns full string definition for message of type '<gridRow>"
  (cl:format cl:nil "gridPoint[] row~%~%================================================================================~%MSG: nav_planner/gridPoint~%int8 init~%int8 proc~%int8 disc~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gridRow)))
  "Returns full string definition for message of type 'gridRow"
  (cl:format cl:nil "gridPoint[] row~%~%================================================================================~%MSG: nav_planner/gridPoint~%int8 init~%int8 proc~%int8 disc~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gridRow>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'row) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gridRow>))
  "Converts a ROS message object to a list"
  (cl:list 'gridRow
    (cl:cons ':row (row msg))
))
