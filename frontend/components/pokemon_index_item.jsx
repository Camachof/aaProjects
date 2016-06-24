const React = require("react");
const HashHistory = require("react-router").hashHistory;
const PokemonAction = require("../actions/pokemon_actions.js");

const PokemonIndexItem = React.createClass({
  showDetail(){
    HashHistory.push(`pokemon/${this.props.pokemon.id}`);
  },

  render (){
    const that = this;

    return (
      <li className="pokemon-list-item" onClick={that.showDetail}>
        {this.props.pokemon.name + " " + this.props.pokemon.poke_type}
      </li>
    );
  }
});

module.exports = PokemonIndexItem;
