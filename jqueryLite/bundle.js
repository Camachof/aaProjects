/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const DOMNodeCollection = __webpack_require__ (1);

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


/***/ },
/* 1 */
/***/ function(module, exports) {

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


/***/ }
/******/ ]);