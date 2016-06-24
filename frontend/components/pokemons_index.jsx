const React = require("react");
const PokemonStore = require("../stores/pokemon.js");
const PokemonAction = require("../actions/pokemon_actions.js");
const PokemonIndexItem = require("./pokemon_index_item.jsx");

const PokemonsIndex = React.createClass({
  getInitialState(){
    return {pokemons: PokemonStore.all()};
  },

  componentDidMount(){
    this.listener = PokemonStore.addListener(this.onChange);
    PokemonAction.fetchAllPokemons();
  },

  onChange(){
    this.setState({pokemons: PokemonStore.all()});
  },

  componentWillUnmount(){
    this.listener.remove();
  },

  render() {
    return (
      <ul>
        {this.state.pokemons.map(function(pokemon){
          return <PokemonIndexItem pokemon={pokemon} key={pokemon["id"]}/>;
        })}
      </ul>
    );
  }
});

module.exports = PokemonsIndex;
