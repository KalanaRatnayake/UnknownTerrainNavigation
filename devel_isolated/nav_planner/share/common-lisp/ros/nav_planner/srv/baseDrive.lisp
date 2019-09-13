; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude baseDrive-request.msg.html

(cl:defclass <baseDrive-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass baseDrive-request (<baseDrive-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <baseDrive-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'baseDrive-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<baseDrive-request> is deprecated: use nav_planner-srv:baseDrive-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <baseDrive-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:x-val is deprecated.  Use nav_planner-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <baseDrive-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:y-val is deprecated.  Use nav_planner-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <baseDrive-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:z-val is deprecated.  Use nav_planner-srv:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <baseDrive-request>) ostream)
  "Serializes a message object of type '<baseDrive-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <baseDrive-request>) istream)
  "Deserializes a message object of type '<baseDrive-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<baseDrive-request>)))
  "Returns string type for a service object of type '<baseDrive-request>"
  "nav_planner/baseDriveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'baseDrive-request)))
  "Returns string type for a service object of type 'baseDrive-request"
  "nav_planner/baseDriveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<baseDrive-request>)))
  "Returns md5sum for a message object of type '<baseDrive-request>"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'baseDrive-request)))
  "Returns md5sum for a message object of type 'baseDrive-request"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<baseDrive-request>)))
  "Returns full string definition for message of type '<baseDrive-request>"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'baseDrive-request)))
  "Returns full string definition for message of type 'baseDrive-request"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <baseDrive-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <baseDrive-request>))
  "Converts a ROS message object to a list"
  (cl:list 'baseDrive-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
))
;//! \htmlinclude baseDrive-response.msg.html

(cl:defclass <baseDrive-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass baseDrive-response (<baseDrive-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <baseDrive-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'baseDrive-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<baseDrive-response> is deprecated: use nav_planner-srv:baseDrive-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <baseDrive-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:success-val is deprecated.  Use nav_planner-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <baseDrive-response>) ostream)
  "Serializes a message object of type '<baseDrive-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <baseDrive-response>) istream)
  "Deserializes a message object of type '<baseDrive-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<baseDrive-response>)))
  "Returns string type for a service object of type '<baseDrive-response>"
  "nav_planner/baseDriveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'baseDrive-response)))
  "Returns string type for a service object of type 'baseDrive-response"
  "nav_planner/baseDriveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<baseDrive-response>)))
  "Returns md5sum for a message object of type '<baseDrive-response>"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'baseDrive-response)))
  "Returns md5sum for a message object of type 'baseDrive-response"
  "58d59f258ca9f2d2ba375d9428a7f1de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<baseDrive-response>)))
  "Returns full string definition for message of type '<baseDrive-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'baseDrive-response)))
  "Returns full string definition for message of type 'baseDrive-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <baseDrive-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <baseDrive-response>))
  "Converts a ROS message object to a list"
  (cl:list 'baseDrive-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'baseDrive)))
  'baseDrive-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'baseDrive)))
  'baseDrive-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'baseDrive)))
  "Returns string type for a service object of type '<baseDrive>"
  "nav_planner/baseDrive")