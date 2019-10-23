; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude goalControl-request.msg.html

(cl:defclass <goalControl-request> (roslisp-msg-protocol:ros-message)
  ((execute
    :reader execute
    :initarg :execute
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass goalControl-request (<goalControl-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goalControl-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goalControl-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<goalControl-request> is deprecated: use nav_planner-srv:goalControl-request instead.")))

(cl:ensure-generic-function 'execute-val :lambda-list '(m))
(cl:defmethod execute-val ((m <goalControl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:execute-val is deprecated.  Use nav_planner-srv:execute instead.")
  (execute m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goalControl-request>) ostream)
  "Serializes a message object of type '<goalControl-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'execute) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goalControl-request>) istream)
  "Deserializes a message object of type '<goalControl-request>"
    (cl:setf (cl:slot-value msg 'execute) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goalControl-request>)))
  "Returns string type for a service object of type '<goalControl-request>"
  "nav_planner/goalControlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalControl-request)))
  "Returns string type for a service object of type 'goalControl-request"
  "nav_planner/goalControlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goalControl-request>)))
  "Returns md5sum for a message object of type '<goalControl-request>"
  "775389b3da33dec3f4e147b9ecc0a538")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goalControl-request)))
  "Returns md5sum for a message object of type 'goalControl-request"
  "775389b3da33dec3f4e147b9ecc0a538")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goalControl-request>)))
  "Returns full string definition for message of type '<goalControl-request>"
  (cl:format cl:nil "bool execute~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goalControl-request)))
  "Returns full string definition for message of type 'goalControl-request"
  (cl:format cl:nil "bool execute~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goalControl-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goalControl-request>))
  "Converts a ROS message object to a list"
  (cl:list 'goalControl-request
    (cl:cons ':execute (execute msg))
))
;//! \htmlinclude goalControl-response.msg.html

(cl:defclass <goalControl-response> (roslisp-msg-protocol:ros-message)
  ((isNull
    :reader isNull
    :initarg :isNull
    :type cl:boolean
    :initform cl:nil)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0))
)

(cl:defclass goalControl-response (<goalControl-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goalControl-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goalControl-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<goalControl-response> is deprecated: use nav_planner-srv:goalControl-response instead.")))

(cl:ensure-generic-function 'isNull-val :lambda-list '(m))
(cl:defmethod isNull-val ((m <goalControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:isNull-val is deprecated.  Use nav_planner-srv:isNull instead.")
  (isNull m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <goalControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:x-val is deprecated.  Use nav_planner-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <goalControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:y-val is deprecated.  Use nav_planner-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <goalControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:z-val is deprecated.  Use nav_planner-srv:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goalControl-response>) ostream)
  "Serializes a message object of type '<goalControl-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isNull) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goalControl-response>) istream)
  "Deserializes a message object of type '<goalControl-response>"
    (cl:setf (cl:slot-value msg 'isNull) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goalControl-response>)))
  "Returns string type for a service object of type '<goalControl-response>"
  "nav_planner/goalControlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalControl-response)))
  "Returns string type for a service object of type 'goalControl-response"
  "nav_planner/goalControlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goalControl-response>)))
  "Returns md5sum for a message object of type '<goalControl-response>"
  "775389b3da33dec3f4e147b9ecc0a538")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goalControl-response)))
  "Returns md5sum for a message object of type 'goalControl-response"
  "775389b3da33dec3f4e147b9ecc0a538")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goalControl-response>)))
  "Returns full string definition for message of type '<goalControl-response>"
  (cl:format cl:nil "bool isNull~%float32 x~%float32 y~%float32 z~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goalControl-response)))
  "Returns full string definition for message of type 'goalControl-response"
  (cl:format cl:nil "bool isNull~%float32 x~%float32 y~%float32 z~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goalControl-response>))
  (cl:+ 0
     1
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goalControl-response>))
  "Converts a ROS message object to a list"
  (cl:list 'goalControl-response
    (cl:cons ':isNull (isNull msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'goalControl)))
  'goalControl-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'goalControl)))
  'goalControl-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalControl)))
  "Returns string type for a service object of type '<goalControl>"
  "nav_planner/goalControl")