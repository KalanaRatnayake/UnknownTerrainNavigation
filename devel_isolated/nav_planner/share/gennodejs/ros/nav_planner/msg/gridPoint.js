// Auto-generated. Do not edit!

// (in-package nav_planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class gridPoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.init = null;
      this.proc = null;
    }
    else {
      if (initObj.hasOwnProperty('init')) {
        this.init = initObj.init
      }
      else {
        this.init = 0;
      }
      if (initObj.hasOwnProperty('proc')) {
        this.proc = initObj.proc
      }
      else {
        this.proc = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gridPoint
    // Serialize message field [init]
    bufferOffset = _serializer.int8(obj.init, buffer, bufferOffset);
    // Serialize message field [proc]
    bufferOffset = _serializer.int8(obj.proc, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gridPoint
    let len;
    let data = new gridPoint(null);
    // Deserialize message field [init]
    data.init = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [proc]
    data.proc = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 2;
  }

  static datatype() {
    // Returns string type for a message object
    return 'nav_planner/gridPoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '38ba4a3cfac6a3fecf591ee30dc4f1b4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8 init
    int8 proc
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gridPoint(null);
    if (msg.init !== undefined) {
      resolved.init = msg.init;
    }
    else {
      resolved.init = 0
    }

    if (msg.proc !== undefined) {
      resolved.proc = msg.proc;
    }
    else {
      resolved.proc = 0
    }

    return resolved;
    }
};

module.exports = gridPoint;
