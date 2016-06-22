"use strict";
const Store = require('flux/utils').Store;
const dispatcher = require('../dispatcher.js');

let _clickCount = 0;

const ClickStore = new Store(dispatcher);

ClickStore.count = function () {
  return _clickCount;
};

ClickStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case 'increment':
    _clickCount++;
    ClickStore.__emitChange();
  }
};

module.exports = ClickStore;
