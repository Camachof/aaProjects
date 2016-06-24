const React = require("react");
const HashHistory = require("react-router").hashHistory;

const ToyIndexItem = React.createClass({
  navigate(){
    HashHistory.push(`pokemon/:pokemonId/toys/${this.props.id}`);
  },

  render () {
    return (
        <li className="toy-list-item" onClick={this.navigate}>
          Name: {this.props.name}
          <br/>Happiness: {this.props.happiness}
          <br/>Price: {this.props.price}
        </li>
    );
  }
});

module.exports = ToyIndexItem;
