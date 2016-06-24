const Dispatcher = require("../dispatcher/dispatcher.js");
const PokemonConstants = require("../constants/pokemon_constants.js");
const ApiUtil = require("../util/api_utils.js");


const PokemonActions = {
  receiveAllPokemons: function (collection) {
    Dispatcher.dispatch({
      actionType: PokemonConstants.POKEMONS_RECEIVED,
      pokemons: collection
    });
  },

  fetchAllPokemons: function () {
    ApiUtil.fetchAllPokemons(PokemonActions.receiveAllPokemons);
  },

  receiveSinglePokemon: function (props) {
    Dispatcher.dispatch({
      actionType: PokemonConstants.POKEMON_RECEIVED,
      props: props
    });
  },

  fetchPokemon(id){
    ApiUtil.fetchPokemon(id, PokemonActions.receiveSinglePokemon);
  }
};

window.PokemonActions = PokemonActions;
module.exports = PokemonActions;
