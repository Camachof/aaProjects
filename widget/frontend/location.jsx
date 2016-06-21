"use strict";

const React = require('react');
const Weather = require('./weather.jsx');

const Location = React.createClass({
  getInitialState(){
    return {coord: []};
  },

  componentWillMount(){
    navigator.geolocation.getCurrentPosition( pos => {
      this.setState({coord: [pos.coords.latitude, pos.coords.longitude]});
    });
  },

  render(){
    return (
      <ul>
        <h2>Latitude: {this.state.coord[0]} Longitude: {this.state.coord[1]}</h2>
        <Weather location={this.state.coord}/>
      </ul>
    );
  }

});



module.exports = Location;
