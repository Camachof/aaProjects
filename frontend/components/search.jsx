const React = require("react");
const BenchMap = require("./bench_map");
const BenchIndex = require("./bench_index");

const Search = React.createClass({
  render(){
    return(<div>search<BenchMap /><BenchIndex /></div>);
  }
});

module.exports = Search;
