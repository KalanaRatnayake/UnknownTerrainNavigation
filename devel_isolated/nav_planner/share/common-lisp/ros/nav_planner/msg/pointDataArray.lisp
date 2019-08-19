; Auto-generated. Do not edit!


(cl:in-package nav_planner-msg)


;//! \htmlinclude pointDataArray.msg.html

(cl:defclass <pointDataArray> (roslisp-msg-protocol:ros-message)
  ((centerPointsArray
    :reader centerPointsArray
    :initarg :centerPointsArray
    :type (cl:vector nav_planner-msg:pointData)
   :initform (cl:make-array 0 :element-type 'nav_planner-msg:pointData :initial-element (cl:make-instance 'nav_planner-msg:pointData))))
)

(cl:defclass pointDataArray (<pointDataArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pointDataArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pointDataArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-msg:<pointDataArray> is deprecated: use nav_planner-msg:pointDataArray instead.")))

(cl:ensure-generic-function 'centerPointsArray-val :lambda-list '(m))
(cl:defmethod centerPointsArray-val ((m <pointDataArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-msg:centerPointsArray-val is deprecated.  Use nav_planner-msg:centerPointsArray instead.")
  (centerPointsArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pointDataArray>) ostream)
  "Serializes a message object of type '<pointDataArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'centerPointsArray))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'centerPointsArray))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pointDataArray>) istream)
  "Deserializes a message object of type '<pointDataArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'centerPointsArray) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'centerPointsArray)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'nav_planner-msg:pointData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pointDataArray>)))
  "Returns string type for a message object of type '<pointDataArray>"
  "nav_planner/pointDataArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pointDataArray)))
  "Returns string type for a message object of type 'pointDataArray"
  "nav_planner/pointDataArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pointDataArray>)))
  "Returns md5sum for a message object of type '<pointDataArray>"
  "a6fd97a183dd670c18cc87cf38ec2735")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pointDataArray)))
  "Returns md5sum for a message object of type 'pointDataArray"
  "a6fd97a183dd670c18cc87cf38ec2735")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pointDataArray>)))
  "Returns full string definition for message of type '<pointDataArray>"
  (cl:format cl:nil "pointData[] centerPointsArray~%~%================================================================================~%MSG: nav_planner/pointData~%float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pointDataArray)))
  "Returns full string definition for message of type 'pointDataArray"
  (cl:format cl:nil "pointData[] centerPointsArray~%~%================================================================================~%MSG: nav_planner/pointData~%float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pointDataArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'centerPointsArray) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pointDataArray>))
  "Converts a ROS message object to a list"
  (cl:list 'pointDataArray
    (cl:cons ':centerPointsArray (centerPointsArray msg))
))
