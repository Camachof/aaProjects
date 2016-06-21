"use strict";

const React = require('react');
const ReactDOM = require('react-dom');
const Widgets = require('./widgets.jsx');


document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<Widgets/>, document.getElementById('test'));
});
