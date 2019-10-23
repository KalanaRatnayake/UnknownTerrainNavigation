; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude mapSave-request.msg.html

(cl:defclass <mapSave-request> (roslisp-msg-protocol:ros-message)
  ((save
    :reader save
    :initarg :save
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass mapSave-request (<mapSave-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <mapSave-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'mapSave-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<mapSave-request> is deprecated: use nav_planner-srv:mapSave-request instead.")))

(cl:ensure-generic-function 'save-val :lambda-list '(m))
(cl:defmethod save-val ((m <mapSave-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:save-val is deprecated.  Use nav_planner-srv:save instead.")
  (save m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <mapSave-request>) ostream)
  "Serializes a message object of type '<mapSave-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'save) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <mapSave-request>) istream)
  "Deserializes a message object of type '<mapSave-request>"
    (cl:setf (cl:slot-value msg 'save) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<mapSave-request>)))
  "Returns string type for a service object of type '<mapSave-request>"
  "nav_planner/mapSaveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mapSave-request)))
  "Returns string type for a service object of type 'mapSave-request"
  "nav_planner/mapSaveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<mapSave-request>)))
  "Returns md5sum for a message object of type '<mapSave-request>"
  "f6ec99713685605bc49d86e471c42eb7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'mapSave-request)))
  "Returns md5sum for a message object of type 'mapSave-request"
  "f6ec99713685605bc49d86e471c42eb7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<mapSave-request>)))
  "Returns full string definition for message of type '<mapSave-request>"
  (cl:format cl:nil "bool save~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'mapSave-request)))
  "Returns full string definition for message of type 'mapSave-request"
  (cl:format cl:nil "bool save~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <mapSave-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <mapSave-request>))
  "Converts a ROS message object to a list"
  (cl:list 'mapSave-request
    (cl:cons ':save (save msg))
))
;//! \htmlinclude mapSave-response.msg.html

(cl:defclass <mapSave-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass mapSave-response (<mapSave-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <mapSave-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'mapSave-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<mapSave-response> is deprecated: use nav_planner-srv:mapSave-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <mapSave-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:success-val is deprecated.  Use nav_planner-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <mapSave-response>) ostream)
  "Serializes a message object of type '<mapSave-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <mapSave-response>) istream)
  "Deserializes a message object of type '<mapSave-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<mapSave-response>)))
  "Returns string type for a service object of type '<mapSave-response>"
  "nav_planner/mapSaveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mapSave-response)))
  "Returns string type for a service object of type 'mapSave-response"
  "nav_planner/mapSaveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<mapSave-response>)))
  "Returns md5sum for a message object of type '<mapSave-response>"
  "f6ec99713685605bc49d86e471c42eb7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'mapSave-response)))
  "Returns md5sum for a message object of type 'mapSave-response"
  "f6ec99713685605bc49d86e471c42eb7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<mapSave-response>)))
  "Returns full string definition for message of type '<mapSave-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'mapSave-response)))
  "Returns full string definition for message of type 'mapSave-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <mapSave-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <mapSave-response>))
  "Converts a ROS message object to a list"
  (cl:list 'mapSave-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'mapSave)))
  'mapSave-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'mapSave)))
  'mapSave-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mapSave)))
  "Returns string type for a service object of type '<mapSave>"
  "nav_planner/mapSave")