const BenchConstants = require("../constants/bench_constants");
const BenchApiUtil = require("../util/bench_api_util");
const AppDispatcher = require("../dispatcher/dispatcher");

const BenchActions = {
  fetchAllBenches(bounds){
    BenchApiUtil.fetchAllBenches(bounds, this.receiveAllBenches);
  },
  createBench(bench){
    BenchApiUtil.createBench(bench, this.receiveBench);
  },
  receiveAllBenches(benches){
    AppDispatcher.dispatch({
      actionType: BenchConstants.BENCHES_RECEIVED,
      benches: benches
    });
  },
  receiveBench(bench){
    AppDispatcher.dispatch({
      actionType: BenchConstants.BENCH_RECEIVED,
      bench: bench
    });
  }
};

module.exports = BenchActions;
