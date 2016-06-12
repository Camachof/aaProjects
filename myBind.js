"use strict";

function Lamp() {
   this.name = "a lamp";
}

const turnOn = function() {
   console.log("Turning on " + this.name);
};

const lamp = new Lamp();

Function.prototype.myBind = function(context) {
  return () => { this.apply(context); };
};

// const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

// console.log(boundTurnOn());
console.log(myBoundTurnOn());
