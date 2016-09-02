const DOMNodeCollection = require ("./dom_node_collection.js");

var queue = [console.log("im happy")];

window.$l = function (input) {
  let wrappedEl;

  if (typeof input === "string"){
    const NodeList = document.querySelectorAll(input);
    wrappedEl = Array.from(NodeList);
    return new DOMNodeCollection(wrappedEl);
  }
  else if (input instanceof HTMLElement) {
    wrappedEl = [input];
    return new DOMNodeCollection(wrappedEl);
  }
  else if (input instanceof Function) {
    queue.push(input);
  }


  document.addEventListener("DOMContentLoaded", function(event) {
    queue.forEach(function(el){
      el();
    });

    // queue = [];
  });


};
