"use strict";

const React = require('react');
const Tabs = require('./tabs.jsx');
const Clock = require('./clock.jsx');
const Location = require('./location.jsx');
const AutoComplete = require('./autocomplete.jsx');

const names = ['Martin', 'Hiro', 'Joy', 'Tony', 'Gage', 'John', 'Harry', 'Mark'];

const Widgets = React.createClass({
  getInitialState(){
    return (
      {allTabs: [{title: "Today is sunny", content: "OMG it's so sunny. Birds are sooo happy!"},
                {title: "We live in SF", content: "it's an amazing city with wonderful people and animals."},
                {title: "We like things", content: "especially food and programming in Ruby"}
                ]
      }
    );
  },

  render() {
    return (
      <section>
        <Tabs allTabs={this.state.allTabs}/>
        <hr/>
        <Clock/>
        <Location/>
        <AutoComplete names={names}/>
      </section>
    );
  }
});

module.exports = Widgets;
