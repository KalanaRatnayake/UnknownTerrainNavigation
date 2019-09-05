; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude mapControl-request.msg.html

(cl:defclass <mapControl-request> (roslisp-msg-protocol:ros-message)
  ((requestTree
    :reader requestTree
    :initarg :requestTree
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass mapControl-request (<mapControl-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <mapControl-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'mapControl-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<mapControl-request> is deprecated: use nav_planner-srv:mapControl-request instead.")))

(cl:ensure-generic-function 'requestTree-val :lambda-list '(m))
(cl:defmethod requestTree-val ((m <mapControl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:requestTree-val is deprecated.  Use nav_planner-srv:requestTree instead.")
  (requestTree m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <mapControl-request>) ostream)
  "Serializes a message object of type '<mapControl-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'requestTree) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <mapControl-request>) istream)
  "Deserializes a message object of type '<mapControl-request>"
    (cl:setf (cl:slot-value msg 'requestTree) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<mapControl-request>)))
  "Returns string type for a service object of type '<mapControl-request>"
  "nav_planner/mapControlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mapControl-request)))
  "Returns string type for a service object of type 'mapControl-request"
  "nav_planner/mapControlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<mapControl-request>)))
  "Returns md5sum for a message object of type '<mapControl-request>"
  "a2ef632b8b905476992515bef0f3da16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'mapControl-request)))
  "Returns md5sum for a message object of type 'mapControl-request"
  "a2ef632b8b905476992515bef0f3da16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<mapControl-request>)))
  "Returns full string definition for message of type '<mapControl-request>"
  (cl:format cl:nil "bool requestTree~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'mapControl-request)))
  "Returns full string definition for message of type 'mapControl-request"
  (cl:format cl:nil "bool requestTree~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <mapControl-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <mapControl-request>))
  "Converts a ROS message object to a list"
  (cl:list 'mapControl-request
    (cl:cons ':requestTree (requestTree msg))
))
;//! \htmlinclude mapControl-response.msg.html

(cl:defclass <mapControl-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass mapControl-response (<mapControl-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <mapControl-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'mapControl-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<mapControl-response> is deprecated: use nav_planner-srv:mapControl-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <mapControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:success-val is deprecated.  Use nav_planner-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <mapControl-response>) ostream)
  "Serializes a message object of type '<mapControl-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <mapControl-response>) istream)
  "Deserializes a message object of type '<mapControl-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<mapControl-response>)))
  "Returns string type for a service object of type '<mapControl-response>"
  "nav_planner/mapControlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mapControl-response)))
  "Returns string type for a service object of type 'mapControl-response"
  "nav_planner/mapControlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<mapControl-response>)))
  "Returns md5sum for a message object of type '<mapControl-response>"
  "a2ef632b8b905476992515bef0f3da16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'mapControl-response)))
  "Returns md5sum for a message object of type 'mapControl-response"
  "a2ef632b8b905476992515bef0f3da16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<mapControl-response>)))
  "Returns full string definition for message of type '<mapControl-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'mapControl-response)))
  "Returns full string definition for message of type 'mapControl-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <mapControl-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <mapControl-response>))
  "Converts a ROS message object to a list"
  (cl:list 'mapControl-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'mapControl)))
  'mapControl-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'mapControl)))
  'mapControl-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mapControl)))
  "Returns string type for a service object of type '<mapControl>"
  "nav_planner/mapControl")