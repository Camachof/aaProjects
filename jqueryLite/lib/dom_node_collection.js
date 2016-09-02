function DOMNodeCollection(array){
  this.nodes = array;
}

DOMNodeCollection.prototype.html = function (string) {
  if (typeof string === "undefined"){
    return this.nodes[0].innerHTML;
  }
  else {
    this.nodes.forEach( function(node) { node.innerHTML = string;});

  }
};

DOMNodeCollection.prototype.empty = function(){
  this.nodes.forEach( function(node) { node.innerHTML = "";});
  this.nodes = [];
};


DOMNodeCollection.prototype.append = function(input){
  const that = this;

  this.nodes.forEach( function(node) {
    node.innerHTML += node.outerHTML;
  });
};

DOMNodeCollection.prototype.attr = function () {
  let returnArr = [];

  if (arguments.length === 1){
    this.nodes.forEach( el => {
      if(el.getAttribute(arguments[0])){
        returnArr.push(el.getAttribute(arguments[0]));
      }
    });
    return returnArr;
  }
  else {
    this.nodes.forEach( el => {
      el.setAttribute(arguments[0], arguments[1]);
    });
  }
};

DOMNodeCollection.prototype.addClass = function (className) {
  this.attr("class", className);
};

DOMNodeCollection.prototype.removeClass = function (className) {

  this.nodes.forEach( el =>{
    if (el.getAttribute("class") === className) {
      console.log("in the if clause");
      el.removeAttribute("class");
    }
  } );
};

DOMNodeCollection.prototype.children = function () {
  const children = [];

  this.nodes.forEach( el => {
    children.push(el.children());
  });

  return new DOMNodeCollection(children);
};

DOMNodeCollection.prototype.parent = function () {
  const parent = [];

  this.nodes.forEach( el => {
    parent.push(el.parent());
  });

  return new DOMNodeCollection(parent);
};

DOMNodeCollection.prototype.find = function (selector) {
  const found = [];

  this.nodes.forEach( el => {
    found.push(el.querySelectorAll(selector));
  });

  return new DOMNodeCollection(found);
};

DOMNodeCollection.prototype.remove = function(selector) {
  this.nodes.forEach( el => {
    el.parentNode.removeChild(el);
  });
};

DOMNodeCollection.prototype.on = function(type, callback){
  this.nodes.forEach( node => {
    node.addEventListener(type, callback);
  });
};

DOMNodeCollection.prototype.off = function(type, callback){
  this.nodes.forEach( node => {
    node.removeEventListener(type, callback);
  });
};

module.exports = DOMNodeCollection;
