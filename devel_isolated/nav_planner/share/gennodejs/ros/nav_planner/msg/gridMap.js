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
let pointData = require('./pointData.js');

//-----------------------------------------------------------

class gridMap {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.grid = null;
      this.path = null;
      this.pathLength = null;
    }
    else {
      if (initObj.hasOwnProperty('grid')) {
        this.grid = initObj.grid
      }
      else {
        this.grid = [];
      }
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = [];
      }
      if (initObj.hasOwnProperty('pathLength')) {
        this.pathLength = initObj.pathLength
      }
      else {
        this.pathLength = 0;
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
    // Serialize message field [path]
    // Serialize the length for message field [path]
    bufferOffset = _serializer.uint32(obj.path.length, buffer, bufferOffset);
    obj.path.forEach((val) => {
      bufferOffset = pointData.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [pathLength]
    bufferOffset = _serializer.int16(obj.pathLength, buffer, bufferOffset);
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
    // Deserialize message field [path]
    // Deserialize array length for message field [path]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.path = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.path[i] = pointData.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [pathLength]
    data.pathLength = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.grid.forEach((val) => {
      length += gridRow.getMessageSize(val);
    });
    length += 12 * object.path.length;
    return length + 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'nav_planner/gridMap';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1e2dc952130c008ed024ffc4c0c5cfad';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    gridRow[] grid
    pointData[] path
    int16 pathLength
    ================================================================================
    MSG: nav_planner/gridRow
    gridPoint[] row
    
    ================================================================================
    MSG: nav_planner/gridPoint
    int8 init
    int8 proc
    int8 disc
    ================================================================================
    MSG: nav_planner/pointData
    float32 x
    float32 y
    float32 z
    
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

    if (msg.path !== undefined) {
      resolved.path = new Array(msg.path.length);
      for (let i = 0; i < resolved.path.length; ++i) {
        resolved.path[i] = pointData.Resolve(msg.path[i]);
      }
    }
    else {
      resolved.path = []
    }

    if (msg.pathLength !== undefined) {
      resolved.pathLength = msg.pathLength;
    }
    else {
      resolved.pathLength = 0
    }

    return resolved;
    }
};

module.exports = gridMap;
