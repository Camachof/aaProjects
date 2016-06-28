const React = require("react");

const BenchForm = React.createClass({
  getInitialState: function() {
    return {
      description: "", seats: 0
    };
  },
  _updateDescription(e){
    this.setState({description: e.target.value});
  },
  _updateSeats(e){
    this.setState({seats: e.target.value});
  },
  _handleSubmit(e){
    e.preventDefault();

  },
  render(){
    return(
      <form onSubmito={this._handleSubmit}>
        <input type="text" value={this.state.description} onChange={this._updateDescription}/>
        <input type="text" value={this.state.seats} onChange={this._updateSeats}/>
      </form>
    );
  }
});

module.exports = BenchForm;
