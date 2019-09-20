; Auto-generated. Do not edit!


(cl:in-package nav_planner-srv)


;//! \htmlinclude waterDetect-request.msg.html

(cl:defclass <waterDetect-request> (roslisp-msg-protocol:ros-message)
  ((detect
    :reader detect
    :initarg :detect
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass waterDetect-request (<waterDetect-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <waterDetect-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'waterDetect-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<waterDetect-request> is deprecated: use nav_planner-srv:waterDetect-request instead.")))

(cl:ensure-generic-function 'detect-val :lambda-list '(m))
(cl:defmethod detect-val ((m <waterDetect-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:detect-val is deprecated.  Use nav_planner-srv:detect instead.")
  (detect m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <waterDetect-request>) ostream)
  "Serializes a message object of type '<waterDetect-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'detect) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <waterDetect-request>) istream)
  "Deserializes a message object of type '<waterDetect-request>"
    (cl:setf (cl:slot-value msg 'detect) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<waterDetect-request>)))
  "Returns string type for a service object of type '<waterDetect-request>"
  "nav_planner/waterDetectRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'waterDetect-request)))
  "Returns string type for a service object of type 'waterDetect-request"
  "nav_planner/waterDetectRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<waterDetect-request>)))
  "Returns md5sum for a message object of type '<waterDetect-request>"
  "1db7aa6468aac5d9a2abbc22f9783ea6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'waterDetect-request)))
  "Returns md5sum for a message object of type 'waterDetect-request"
  "1db7aa6468aac5d9a2abbc22f9783ea6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<waterDetect-request>)))
  "Returns full string definition for message of type '<waterDetect-request>"
  (cl:format cl:nil "bool detect~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'waterDetect-request)))
  "Returns full string definition for message of type 'waterDetect-request"
  (cl:format cl:nil "bool detect~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <waterDetect-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <waterDetect-request>))
  "Converts a ROS message object to a list"
  (cl:list 'waterDetect-request
    (cl:cons ':detect (detect msg))
))
;//! \htmlinclude waterDetect-response.msg.html

(cl:defclass <waterDetect-response> (roslisp-msg-protocol:ros-message)
  ((left
    :reader left
    :initarg :left
    :type cl:float
    :initform 0.0)
   (middle
    :reader middle
    :initarg :middle
    :type cl:float
    :initform 0.0)
   (right
    :reader right
    :initarg :right
    :type cl:float
    :initform 0.0))
)

(cl:defclass waterDetect-response (<waterDetect-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <waterDetect-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'waterDetect-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav_planner-srv:<waterDetect-response> is deprecated: use nav_planner-srv:waterDetect-response instead.")))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <waterDetect-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:left-val is deprecated.  Use nav_planner-srv:left instead.")
  (left m))

(cl:ensure-generic-function 'middle-val :lambda-list '(m))
(cl:defmethod middle-val ((m <waterDetect-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:middle-val is deprecated.  Use nav_planner-srv:middle instead.")
  (middle m))

(cl:ensure-generic-function 'right-val :lambda-list '(m))
(cl:defmethod right-val ((m <waterDetect-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav_planner-srv:right-val is deprecated.  Use nav_planner-srv:right instead.")
  (right m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <waterDetect-response>) ostream)
  "Serializes a message object of type '<waterDetect-response>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'left))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'middle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'right))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <waterDetect-response>) istream)
  "Deserializes a message object of type '<waterDetect-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'left) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'middle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'right) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<waterDetect-response>)))
  "Returns string type for a service object of type '<waterDetect-response>"
  "nav_planner/waterDetectResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'waterDetect-response)))
  "Returns string type for a service object of type 'waterDetect-response"
  "nav_planner/waterDetectResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<waterDetect-response>)))
  "Returns md5sum for a message object of type '<waterDetect-response>"
  "1db7aa6468aac5d9a2abbc22f9783ea6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'waterDetect-response)))
  "Returns md5sum for a message object of type 'waterDetect-response"
  "1db7aa6468aac5d9a2abbc22f9783ea6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<waterDetect-response>)))
  "Returns full string definition for message of type '<waterDetect-response>"
  (cl:format cl:nil "float32 left~%float32 middle~%float32 right~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'waterDetect-response)))
  "Returns full string definition for message of type 'waterDetect-response"
  (cl:format cl:nil "float32 left~%float32 middle~%float32 right~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <waterDetect-response>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <waterDetect-response>))
  "Converts a ROS message object to a list"
  (cl:list 'waterDetect-response
    (cl:cons ':left (left msg))
    (cl:cons ':middle (middle msg))
    (cl:cons ':right (right msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'waterDetect)))
  'waterDetect-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'waterDetect)))
  'waterDetect-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'waterDetect)))
  "Returns string type for a service object of type '<waterDetect>"
  "nav_planner/waterDetect")