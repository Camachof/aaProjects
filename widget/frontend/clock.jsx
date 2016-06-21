"use strict";

const React = require('react');

const Clock = React.createClass({
  getInitialState(){
    return ({time: new Date()});
  },

  componentDidMount(){
    this.clockId = setInterval(this.tick, 1000);
  },

  tick() {
    let now = this.state.time;
    now.setSeconds(this.state.time.getSeconds() + 1);
    this.setState({time: now});
  },

  click(){
    clearInterval(this.clockId);
  },

  render(){
    return (
      <p onClick={this.click}>
        {this.state.time.getHours()}:
        {this.state.time.getMinutes()}:
        {this.state.time.getSeconds()}
      </p>
    );
  }

});

module.exports = Clock;
