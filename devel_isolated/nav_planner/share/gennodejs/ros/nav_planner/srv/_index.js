
"use strict";

let baseDrive = require('./baseDrive.js')
let baseRotate = require('./baseRotate.js')
let waterDetect = require('./waterDetect.js')
let goalControl = require('./goalControl.js')

module.exports = {
  baseDrive: baseDrive,
  baseRotate: baseRotate,
  waterDetect: waterDetect,
  goalControl: goalControl,
};
