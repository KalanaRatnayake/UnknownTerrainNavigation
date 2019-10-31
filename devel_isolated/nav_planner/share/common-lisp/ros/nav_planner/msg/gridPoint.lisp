; Auto-generated. Do not edit!


(cl:in-package nav_planner-msg)


;//! \htmlinclude gridPoint.msg.html

(cl:defclass <gridPoint> (roslisp-msg-protocol:ros-message)
  ((init
    :reader init
    :initarg :init
    :type cl:fixnum
    :initform 0)
   (proc
    :reader proc
    :initarg :proc
    :type cl:fixnum
    :initform 0))
)

(cl:defclass gridPoint (<gridPoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gridPoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gridPoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-msg:<gridPoint> is deprecated: use nav_planner-msg:gridPoint instead.")))

(cl:ensure-generic-function 'init-val :lambda-list '(m))
(cl:defmethod init-val ((m <gridPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:init-val is deprecated.  Use nav_planner-msg:init instead.")
  (init m))

(cl:ensure-generic-function 'proc-val :lambda-list '(m))
(cl:defmethod proc-val ((m <gridPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:proc-val is deprecated.  Use nav_planner-msg:proc instead.")
  (proc m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gridPoint>) ostream)
  "Serializes a message object of type '<gridPoint>"
  (cl:let* ((signed (cl:slot-value msg 'init)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'proc)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gridPoint>) istream)
  "Deserializes a message object of type '<gridPoint>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'init) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'proc) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gridPoint>)))
  "Returns string type for a message object of type '<gridPoint>"
  "nav_planner/gridPoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gridPoint)))
  "Returns string type for a message object of type 'gridPoint"
  "nav_planner/gridPoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gridPoint>)))
  "Returns md5sum for a message object of type '<gridPoint>"
  "38ba4a3cfac6a3fecf591ee30dc4f1b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gridPoint)))
  "Returns md5sum for a message object of type 'gridPoint"
  "38ba4a3cfac6a3fecf591ee30dc4f1b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gridPoint>)))
  "Returns full string definition for message of type '<gridPoint>"
  (cl:format cl:nil "int8 init~%int8 proc~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gridPoint)))
  "Returns full string definition for message of type 'gridPoint"
  (cl:format cl:nil "int8 init~%int8 proc~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gridPoint>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gridPoint>))
  "Converts a ROS message object to a list"
  (cl:list 'gridPoint
    (cl:cons ':init (init msg))
    (cl:cons ':proc (proc msg))
))
