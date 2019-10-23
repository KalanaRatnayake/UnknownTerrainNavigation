// Auto-generated. Do not edit!

// (in-package nav_planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let gridRow = require('./gridRow.js');

//-----------------------------------------------------------

class gridMap {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.grid = null;
    }
    else {
      if (initObj.hasOwnProperty('grid')) {
        this.grid = initObj.grid
      }
      else {
        this.grid = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gridMap
    // Serialize message field [grid]
    // Serialize the length for message field [grid]
    bufferOffset = _serializer.uint32(obj.grid.length, buffer, bufferOffset);
    obj.grid.forEach((val) => {
      bufferOffset = gridRow.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gridMap
    let len;
    let data = new gridMap(null);
    // Deserialize message field [grid]
    // Deserialize array length for message field [grid]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.grid = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.grid[i] = gridRow.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.grid.forEach((val) => {
      length += gridRow.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'nav_planner/gridMap';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '871833bd332a580973308691ab02d68a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    gridRow[] grid
    
    ================================================================================
    MSG: nav_planner/gridRow
    gridPoint[] row
    
    ================================================================================
    MSG: nav_planner/gridPoint
    int8 init
    int8 proc
    int8 path
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gridMap(null);
    if (msg.grid !== undefined) {
      resolved.grid = new Array(msg.grid.length);
      for (let i = 0; i < resolved.grid.length; ++i) {
        resolved.grid[i] = gridRow.Resolve(msg.grid[i]);
      }
    }
    else {
      resolved.grid = []
    }

    return resolved;
    }
};

module.exports = gridMap;
