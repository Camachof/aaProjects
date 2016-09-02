const dispatcher = require('../dispatcher.js');

module.exports = {
  increment: function() {
    dispatcher.dispatch({
      actionType: "increment",
    });
  }
};
