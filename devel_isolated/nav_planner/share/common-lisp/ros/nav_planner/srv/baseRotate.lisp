; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude baseRotate-request.msg.html

(cl:defclass <baseRotate-request> (roslisp-msg-protocol:ros-message)
  ((execute
    :reader execute
    :initarg :execute
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass baseRotate-request (<baseRotate-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <baseRotate-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'baseRotate-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<baseRotate-request> is deprecated: use nav_planner-srv:baseRotate-request instead.")))

(cl:ensure-generic-function 'execute-val :lambda-list '(m))
(cl:defmethod execute-val ((m <baseRotate-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:execute-val is deprecated.  Use nav_planner-srv:execute instead.")
  (execute m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <baseRotate-request>) ostream)
  "Serializes a message object of type '<baseRotate-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'execute) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <baseRotate-request>) istream)
  "Deserializes a message object of type '<baseRotate-request>"
    (cl:setf (cl:slot-value msg 'execute) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<baseRotate-request>)))
  "Returns string type for a service object of type '<baseRotate-request>"
  "nav_planner/baseRotateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'baseRotate-request)))
  "Returns string type for a service object of type 'baseRotate-request"
  "nav_planner/baseRotateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<baseRotate-request>)))
  "Returns md5sum for a message object of type '<baseRotate-request>"
  "a933da1aed447ccd941e96046fc95d53")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'baseRotate-request)))
  "Returns md5sum for a message object of type 'baseRotate-request"
  "a933da1aed447ccd941e96046fc95d53")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<baseRotate-request>)))
  "Returns full string definition for message of type '<baseRotate-request>"
  (cl:format cl:nil "bool execute~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'baseRotate-request)))
  "Returns full string definition for message of type 'baseRotate-request"
  (cl:format cl:nil "bool execute~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <baseRotate-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <baseRotate-request>))
  "Converts a ROS message object to a list"
  (cl:list 'baseRotate-request
    (cl:cons ':execute (execute msg))
))
;//! \htmlinclude baseRotate-response.msg.html

(cl:defclass <baseRotate-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass baseRotate-response (<baseRotate-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <baseRotate-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'baseRotate-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<baseRotate-response> is deprecated: use nav_planner-srv:baseRotate-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <baseRotate-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:success-val is deprecated.  Use nav_planner-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <baseRotate-response>) ostream)
  "Serializes a message object of type '<baseRotate-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <baseRotate-response>) istream)
  "Deserializes a message object of type '<baseRotate-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<baseRotate-response>)))
  "Returns string type for a service object of type '<baseRotate-response>"
  "nav_planner/baseRotateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'baseRotate-response)))
  "Returns string type for a service object of type 'baseRotate-response"
  "nav_planner/baseRotateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<baseRotate-response>)))
  "Returns md5sum for a message object of type '<baseRotate-response>"
  "a933da1aed447ccd941e96046fc95d53")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'baseRotate-response)))
  "Returns md5sum for a message object of type 'baseRotate-response"
  "a933da1aed447ccd941e96046fc95d53")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<baseRotate-response>)))
  "Returns full string definition for message of type '<baseRotate-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'baseRotate-response)))
  "Returns full string definition for message of type 'baseRotate-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <baseRotate-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <baseRotate-response>))
  "Converts a ROS message object to a list"
  (cl:list 'baseRotate-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'baseRotate)))
  'baseRotate-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'baseRotate)))
  'baseRotate-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'baseRotate)))
  "Returns string type for a service object of type '<baseRotate>"
  "nav_planner/baseRotate")