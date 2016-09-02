const React = require("react");
const BenchStore = require("../stores/bench_store");
const BenchActions = require("../actions/bench_actions");
const BenchIndexItem = require("../components/bench_index_item");

const BenchIndex = React.createClass({
  getInitialState: function() {
    return {
      benches: BenchStore.all()
    };
  },
  componentDidMount(){
    BenchStore.addListener(this._handleChange);
  },
  _handleChange(){
    this.setState({benches: BenchStore.all()});
  },
  render(){
    return(
      <div>
        {
          Object.keys(this.state.benches).map((benchId) => {
            return (<div>{this.state.benches[benchId].description}</div>);
          })
        }
    </div>
  );
  }
});

module.exports = BenchIndex;
