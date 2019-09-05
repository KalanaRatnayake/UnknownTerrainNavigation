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

class mapControlRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.requestTree = null;
    }
    else {
      if (initObj.hasOwnProperty('requestTree')) {
        this.requestTree = initObj.requestTree
      }
      else {
        this.requestTree = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type mapControlRequest
    // Serialize message field [requestTree]
    bufferOffset = _serializer.bool(obj.requestTree, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type mapControlRequest
    let len;
    let data = new mapControlRequest(null);
    // Deserialize message field [requestTree]
    data.requestTree = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'nav_planner/mapControlRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c17e1270e073c6ebb2aca9096a5fb9e1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool requestTree
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new mapControlRequest(null);
    if (msg.requestTree !== undefined) {
      resolved.requestTree = msg.requestTree;
    }
    else {
      resolved.requestTree = false
    }

    return resolved;
    }
};

class mapControlResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type mapControlResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type mapControlResponse
    let len;
    let data = new mapControlResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'nav_planner/mapControlResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '358e233cde0c8a8bcfea4ce193f8fc15';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new mapControlResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    return resolved;
    }
};

module.exports = {
  Request: mapControlRequest,
  Response: mapControlResponse,
  md5sum() { return 'a2ef632b8b905476992515bef0f3da16'; },
  datatype() { return 'nav_planner/mapControl'; }
};
