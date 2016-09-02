"use strict";

const React = require('react');

const Tabs = React.createClass({
  getInitialState(){
    return ({selected: NaN});
  },

  click(index){
    this.setState({selected: index});
  },

  render(){
    const tabTitles = this.props.allTabs.map((tab, index) => {
        let selected = "";
        let content = "";

        if (index === this.state.selected){
          selected = "selected";
          content = tab['content'];
        }
        return (
                <h1 key={tab['title']}
                  className={selected}
                  onClick={this.click.bind(this, index)}>
                  {tab['title']}
                  <li>{content}</li>
                </h1>);
    });

    return (
      <ul>
        {tabTitles}
      </ul>
    );
  }
});

module.exports = Tabs;
