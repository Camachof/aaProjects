
const BenchApiUtil = {
  fetchAllBenches(bounds, callback){
    $.ajax({
      url: "/api/benches",
      type: "GET",
      dataType: "json",
      data: {bounds: bounds},
      success: function(response){
        callback(response);
      }
    });
  },
  createBench(bench, callback){
    $.ajax({
      url: "/api/benches",
      type: "POST",
      dataType: "json",
      data: {bench: bench},
      success: function(response){
        callback(response);
      }
    });
  }
};

window.BenchApiUtil = BenchApiUtil;
module.exports = BenchApiUtil;
