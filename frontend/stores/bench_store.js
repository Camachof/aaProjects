const React = require("react");
const Store = require("flux/utils").Store;
const AppDispatcher = require("../dispatcher/dispatcher");
const BenchConstants = require("../constants/bench_constants");

let _benches = {};

const BenchStore = new Store(AppDispatcher);

BenchStore.__onDispatch = function(payload){
  switch (payload.actionType) {
    case BenchConstants.BENCHES_RECEIVED:
      BenchStore.resetAllBenches(payload.benches);
      BenchStore.__emitChange();
      break;
  }
};

BenchStore.all = function(){
  return _benches;
};

BenchStore.resetAllBenches = function(benches){
  _benches = {};
  benches.forEach(function(bench){
    _benches[bench.id] = bench;
  });
};

module.exports = BenchStore;
