
"use strict";

let mapSave = require('./mapSave.js')
let baseDrive = require('./baseDrive.js')
let goalRemove = require('./goalRemove.js')
let systemControl = require('./systemControl.js')
let baseRotate = require('./baseRotate.js')
let waterDetect = require('./waterDetect.js')
let goalControl = require('./goalControl.js')

module.exports = {
  mapSave: mapSave,
  baseDrive: baseDrive,
  goalRemove: goalRemove,
  systemControl: systemControl,
  baseRotate: baseRotate,
  waterDetect: waterDetect,
  goalControl: goalControl,
};
