; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude systemControl-request.msg.html

(cl:defclass <systemControl-request> (roslisp-msg-protocol:ros-message)
  ((activate
    :reader activate
    :initarg :activate
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass systemControl-request (<systemControl-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <systemControl-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'systemControl-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<systemControl-request> is deprecated: use nav_planner-srv:systemControl-request instead.")))

(cl:ensure-generic-function 'activate-val :lambda-list '(m))
(cl:defmethod activate-val ((m <systemControl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:activate-val is deprecated.  Use nav_planner-srv:activate instead.")
  (activate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <systemControl-request>) ostream)
  "Serializes a message object of type '<systemControl-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'activate) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <systemControl-request>) istream)
  "Deserializes a message object of type '<systemControl-request>"
    (cl:setf (cl:slot-value msg 'activate) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<systemControl-request>)))
  "Returns string type for a service object of type '<systemControl-request>"
  "nav_planner/systemControlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'systemControl-request)))
  "Returns string type for a service object of type 'systemControl-request"
  "nav_planner/systemControlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<systemControl-request>)))
  "Returns md5sum for a message object of type '<systemControl-request>"
  "28dadd83d564c0f1c7317577c2a315b5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'systemControl-request)))
  "Returns md5sum for a message object of type 'systemControl-request"
  "28dadd83d564c0f1c7317577c2a315b5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<systemControl-request>)))
  "Returns full string definition for message of type '<systemControl-request>"
  (cl:format cl:nil "bool activate~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'systemControl-request)))
  "Returns full string definition for message of type 'systemControl-request"
  (cl:format cl:nil "bool activate~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <systemControl-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <systemControl-request>))
  "Converts a ROS message object to a list"
  (cl:list 'systemControl-request
    (cl:cons ':activate (activate msg))
))
;//! \htmlinclude systemControl-response.msg.html

(cl:defclass <systemControl-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass systemControl-response (<systemControl-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <systemControl-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'systemControl-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<systemControl-response> is deprecated: use nav_planner-srv:systemControl-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <systemControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:success-val is deprecated.  Use nav_planner-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <systemControl-response>) ostream)
  "Serializes a message object of type '<systemControl-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <systemControl-response>) istream)
  "Deserializes a message object of type '<systemControl-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<systemControl-response>)))
  "Returns string type for a service object of type '<systemControl-response>"
  "nav_planner/systemControlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'systemControl-response)))
  "Returns string type for a service object of type 'systemControl-response"
  "nav_planner/systemControlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<systemControl-response>)))
  "Returns md5sum for a message object of type '<systemControl-response>"
  "28dadd83d564c0f1c7317577c2a315b5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'systemControl-response)))
  "Returns md5sum for a message object of type 'systemControl-response"
  "28dadd83d564c0f1c7317577c2a315b5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<systemControl-response>)))
  "Returns full string definition for message of type '<systemControl-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'systemControl-response)))
  "Returns full string definition for message of type 'systemControl-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <systemControl-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <systemControl-response>))
  "Converts a ROS message object to a list"
  (cl:list 'systemControl-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'systemControl)))
  'systemControl-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'systemControl)))
  'systemControl-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'systemControl)))
  "Returns string type for a service object of type '<systemControl>"
  "nav_planner/systemControl")