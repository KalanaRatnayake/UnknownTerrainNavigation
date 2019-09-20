// Auto-generated. Do not edit!

// (in-package nav_planner.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class waterDetectRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.detect = null;
    }
    else {
      if (initObj.hasOwnProperty('detect')) {
        this.detect = initObj.detect
      }
      else {
        this.detect = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type waterDetectRequest
    // Serialize message field [detect]
    bufferOffset = _serializer.bool(obj.detect, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type waterDetectRequest
    let len;
    let data = new waterDetectRequest(null);
    // Deserialize message field [detect]
    data.detect = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'nav_planner/waterDetectRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '75e83bb3bd22c91435365dfc6ce294b7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool detect
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new waterDetectRequest(null);
    if (msg.detect !== undefined) {
      resolved.detect = msg.detect;
    }
    else {
      resolved.detect = false
    }

    return resolved;
    }
};

class waterDetectResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.left = null;
      this.middle = null;
      this.right = null;
    }
    else {
      if (initObj.hasOwnProperty('left')) {
        this.left = initObj.left
      }
      else {
        this.left = 0.0;
      }
      if (initObj.hasOwnProperty('middle')) {
        this.middle = initObj.middle
      }
      else {
        this.middle = 0.0;
      }
      if (initObj.hasOwnProperty('right')) {
        this.right = initObj.right
      }
      else {
        this.right = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type waterDetectResponse
    // Serialize message field [left]
    bufferOffset = _serializer.float32(obj.left, buffer, bufferOffset);
    // Serialize message field [middle]
    bufferOffset = _serializer.float32(obj.middle, buffer, bufferOffset);
    // Serialize message field [right]
    bufferOffset = _serializer.float32(obj.right, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type waterDetectResponse
    let len;
    let data = new waterDetectResponse(null);
    // Deserialize message field [left]
    data.left = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [middle]
    data.middle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [right]
    data.right = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'nav_planner/waterDetectResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '103e35c87f127f93102b26951773e9e2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 left
    float32 middle
    float32 right
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new waterDetectResponse(null);
    if (msg.left !== undefined) {
      resolved.left = msg.left;
    }
    else {
      resolved.left = 0.0
    }

    if (msg.middle !== undefined) {
      resolved.middle = msg.middle;
    }
    else {
      resolved.middle = 0.0
    }

    if (msg.right !== undefined) {
      resolved.right = msg.right;
    }
    else {
      resolved.right = 0.0
    }

    return resolved;
    }
};

module.exports = {
  Request: waterDetectRequest,
  Response: waterDetectResponse,
  md5sum() { return '1db7aa6468aac5d9a2abbc22f9783ea6'; },
  datatype() { return 'nav_planner/waterDetect'; }
};
