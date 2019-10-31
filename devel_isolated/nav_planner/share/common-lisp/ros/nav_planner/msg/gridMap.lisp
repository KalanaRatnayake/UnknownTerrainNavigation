; Auto-generated. Do not edit!


(cl:in-package nav_planner-msg)


;//! \htmlinclude gridMap.msg.html

(cl:defclass <gridMap> (roslisp-msg-protocol:ros-message)
  ((grid
    :reader grid
    :initarg :grid
    :type (cl:vector nav_planner-msg:gridRow)
   :initform (cl:make-array 0 :element-type 'nav_planner-msg:gridRow :initial-element (cl:make-instance 'nav_planner-msg:gridRow)))
   (path
    :reader path
    :initarg :path
    :type (cl:vector nav_planner-msg:pointData)
   :initform (cl:make-array 0 :element-type 'nav_planner-msg:pointData :initial-element (cl:make-instance 'nav_planner-msg:pointData)))
   (pathLength
    :reader pathLength
    :initarg :pathLength
    :type cl:fixnum
    :initform 0))
)

(cl:defclass gridMap (<gridMap>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gridMap>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gridMap)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-msg:<gridMap> is deprecated: use nav_planner-msg:gridMap instead.")))

(cl:ensure-generic-function 'grid-val :lambda-list '(m))
(cl:defmethod grid-val ((m <gridMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:grid-val is deprecated.  Use nav_planner-msg:grid instead.")
  (grid m))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <gridMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:path-val is deprecated.  Use nav_planner-msg:path instead.")
  (path m))

(cl:ensure-generic-function 'pathLength-val :lambda-list '(m))
(cl:defmethod pathLength-val ((m <gridMap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:pathLength-val is deprecated.  Use nav_planner-msg:pathLength instead.")
  (pathLength m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gridMap>) ostream)
  "Serializes a message object of type '<gridMap>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'grid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'grid))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
  (cl:let* ((signed (cl:slot-value msg 'pathLength)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gridMap>) istream)
  "Deserializes a message object of type '<gridMap>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'grid) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'grid)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'nav_planner-msg:gridRow))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'path) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'path)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'nav_planner-msg:pointData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pathLength) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gridMap>)))
  "Returns string type for a message object of type '<gridMap>"
  "nav_planner/gridMap")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gridMap)))
  "Returns string type for a message object of type 'gridMap"
  "nav_planner/gridMap")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gridMap>)))
  "Returns md5sum for a message object of type '<gridMap>"
  "7283370e017ac387872171d01ea443ab")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gridMap)))
  "Returns md5sum for a message object of type 'gridMap"
  "7283370e017ac387872171d01ea443ab")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gridMap>)))
  "Returns full string definition for message of type '<gridMap>"
  (cl:format cl:nil "gridRow[] grid~%pointData[] path~%int16 pathLength~%================================================================================~%MSG: nav_planner/gridRow~%gridPoint[] row~%~%================================================================================~%MSG: nav_planner/gridPoint~%int8 init~%int8 proc~%================================================================================~%MSG: nav_planner/pointData~%float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gridMap)))
  "Returns full string definition for message of type 'gridMap"
  (cl:format cl:nil "gridRow[] grid~%pointData[] path~%int16 pathLength~%================================================================================~%MSG: nav_planner/gridRow~%gridPoint[] row~%~%================================================================================~%MSG: nav_planner/gridPoint~%int8 init~%int8 proc~%================================================================================~%MSG: nav_planner/pointData~%float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gridMap>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'grid) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gridMap>))
  "Converts a ROS message object to a list"
  (cl:list 'gridMap
    (cl:cons ':grid (grid msg))
    (cl:cons ':path (path msg))
    (cl:cons ':pathLength (pathLength msg))
))
