"use strict";

const React = require('react');

const Weather = React.createClass({
  getInitialState(){
    return {response: ""};
  },

  getWeather(p){
    const request = new XMLHttpRequest();
    // console.log(this);
    // console.log(this.props);
    // console.log(this.props.location);
    // debugger;
    // const lat = this.props.location[0];
    // const lon = this.props.location[1];

    const lat = p.location[0];
    const lon = p.location[1];

    request.open('GET',
                  `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=645c5d39c7603f17e23fcaffcea1a3c1`,
                  true);

    request.onload = function(){
      if (request.status >=200 && request.status < 400){
        this.setState({response: request.responseText});
      }

    }.bind(this);
    request.send();
  },

  componentWillMount(){
    this.getWeather(this.props);
  },

  componentWillReceiveProps(newProps){
    this.getWeather(newProps);
  },

  render(){
    return <div>{this.state.response}</div>;
  }

});



module.exports = Weather;
