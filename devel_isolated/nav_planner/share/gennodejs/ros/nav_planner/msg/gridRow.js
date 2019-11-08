// Auto-generated. Do not edit!

// (in-package nav_planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let gridPoint = require('./gridPoint.js');

//-----------------------------------------------------------

class gridRow {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.row = null;
    }
    else {
      if (initObj.hasOwnProperty('row')) {
        this.row = initObj.row
      }
      else {
        this.row = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gridRow
    // Serialize message field [row]
    // Serialize the length for message field [row]
    bufferOffset = _serializer.uint32(obj.row.length, buffer, bufferOffset);
    obj.row.forEach((val) => {
      bufferOffset = gridPoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gridRow
    let len;
    let data = new gridRow(null);
    // Deserialize message field [row]
    // Deserialize array length for message field [row]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.row = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.row[i] = gridPoint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 3 * object.row.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'nav_planner/gridRow';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4077bd51d2ef02451e7ce2c5b9ff044d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    gridPoint[] row
    
    ================================================================================
    MSG: nav_planner/gridPoint
    int8 init
    int8 proc
    int8 disc
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gridRow(null);
    if (msg.row !== undefined) {
      resolved.row = new Array(msg.row.length);
      for (let i = 0; i < resolved.row.length; ++i) {
        resolved.row[i] = gridPoint.Resolve(msg.row[i]);
      }
    }
    else {
      resolved.row = []
    }

    return resolved;
    }
};

module.exports = gridRow;
