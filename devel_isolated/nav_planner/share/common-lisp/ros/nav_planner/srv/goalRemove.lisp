; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude goalRemove-request.msg.html

(cl:defclass <goalRemove-request> (roslisp-msg-protocol:ros-message)
  ((x
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

(cl:defclass goalRemove-request (<goalRemove-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goalRemove-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goalRemove-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<goalRemove-request> is deprecated: use nav_planner-srv:goalRemove-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <goalRemove-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:x-val is deprecated.  Use nav_planner-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <goalRemove-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:y-val is deprecated.  Use nav_planner-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <goalRemove-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:z-val is deprecated.  Use nav_planner-srv:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goalRemove-request>) ostream)
  "Serializes a message object of type '<goalRemove-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goalRemove-request>) istream)
  "Deserializes a message object of type '<goalRemove-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goalRemove-request>)))
  "Returns string type for a service object of type '<goalRemove-request>"
  "nav_planner/goalRemoveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalRemove-request)))
  "Returns string type for a service object of type 'goalRemove-request"
  "nav_planner/goalRemoveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goalRemove-request>)))
  "Returns md5sum for a message object of type '<goalRemove-request>"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goalRemove-request)))
  "Returns md5sum for a message object of type 'goalRemove-request"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goalRemove-request>)))
  "Returns full string definition for message of type '<goalRemove-request>"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goalRemove-request)))
  "Returns full string definition for message of type 'goalRemove-request"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goalRemove-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goalRemove-request>))
  "Converts a ROS message object to a list"
  (cl:list 'goalRemove-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
))
;//! \htmlinclude goalRemove-response.msg.html

(cl:defclass <goalRemove-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass goalRemove-response (<goalRemove-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goalRemove-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goalRemove-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<goalRemove-response> is deprecated: use nav_planner-srv:goalRemove-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <goalRemove-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:success-val is deprecated.  Use nav_planner-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goalRemove-response>) ostream)
  "Serializes a message object of type '<goalRemove-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goalRemove-response>) istream)
  "Deserializes a message object of type '<goalRemove-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goalRemove-response>)))
  "Returns string type for a service object of type '<goalRemove-response>"
  "nav_planner/goalRemoveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalRemove-response)))
  "Returns string type for a service object of type 'goalRemove-response"
  "nav_planner/goalRemoveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goalRemove-response>)))
  "Returns md5sum for a message object of type '<goalRemove-response>"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goalRemove-response)))
  "Returns md5sum for a message object of type 'goalRemove-response"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goalRemove-response>)))
  "Returns full string definition for message of type '<goalRemove-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goalRemove-response)))
  "Returns full string definition for message of type 'goalRemove-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goalRemove-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goalRemove-response>))
  "Converts a ROS message object to a list"
  (cl:list 'goalRemove-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'goalRemove)))
  'goalRemove-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'goalRemove)))
  'goalRemove-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalRemove)))
  "Returns string type for a service object of type '<goalRemove>"
  "nav_planner/goalRemove")