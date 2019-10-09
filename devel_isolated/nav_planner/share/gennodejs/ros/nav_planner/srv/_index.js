
"use strict";

let baseDrive = require('./baseDrive.js')
let systemControl = require('./systemControl.js')
let baseRotate = require('./baseRotate.js')
let waterDetect = require('./waterDetect.js')
let goalControl = require('./goalControl.js')

module.exports = {
  baseDrive: baseDrive,
  systemControl: systemControl,
  baseRotate: baseRotate,
  waterDetect: waterDetect,
  goalControl: goalControl,
};
