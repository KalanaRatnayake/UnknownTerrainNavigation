// Auto-generated. Do not edit!

// (in-package nav_planner.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let pointData = require('./pointData.js');

//-----------------------------------------------------------

class pointDataArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.centerPointsArray = null;
    }
    else {
      if (initObj.hasOwnProperty('centerPointsArray')) {
        this.centerPointsArray = initObj.centerPointsArray
      }
      else {
        this.centerPointsArray = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type pointDataArray
    // Serialize message field [centerPointsArray]
    // Serialize the length for message field [centerPointsArray]
    bufferOffset = _serializer.uint32(obj.centerPointsArray.length, buffer, bufferOffset);
    obj.centerPointsArray.forEach((val) => {
      bufferOffset = pointData.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pointDataArray
    let len;
    let data = new pointDataArray(null);
    // Deserialize message field [centerPointsArray]
    // Deserialize array length for message field [centerPointsArray]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.centerPointsArray = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.centerPointsArray[i] = pointData.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 12 * object.centerPointsArray.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'nav_planner/pointDataArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a6fd97a183dd670c18cc87cf38ec2735';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    pointData[] centerPointsArray
    
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
    const resolved = new pointDataArray(null);
    if (msg.centerPointsArray !== undefined) {
      resolved.centerPointsArray = new Array(msg.centerPointsArray.length);
      for (let i = 0; i < resolved.centerPointsArray.length; ++i) {
        resolved.centerPointsArray[i] = pointData.Resolve(msg.centerPointsArray[i]);
      }
    }
    else {
      resolved.centerPointsArray = []
    }

    return resolved;
    }
};

module.exports = pointDataArray;
