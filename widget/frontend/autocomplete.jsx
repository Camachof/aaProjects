"use strict";

const React = require('react');

const AutoComplete = React.createClass({
  getInitialState(){
    return {textInput: "", matchedNames: []};
  },

  reflectInput(event){
    this.setState({textInput: event.target.value}, this.findMatch);
  },

  findMatch(){
    const matched = [];

    this.props.names.forEach( name => {
      if (name.indexOf(this.state.textInput) !== -1 &&
          this.state.textInput !== ""){
        matched.push(name);
      }
    });

    this.setState({matchedNames: matched.map( (name) => {
        return <li key={name}>{name}</li>;
      })}
    );
  },

  render(){
    return (
      <div>
        <input type="text" value={this.state.textInput} onChange={this.reflectInput}></input>
        <ul>{this.state.matchedNames}</ul>
      </div>
    );
  }
});

module.exports = AutoComplete;
