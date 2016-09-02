const Store = require("flux/utils").Store;
const Dispatcher = require("../dispatcher/dispatcher.js");
const PokemonStore = new Store(Dispatcher);

let _pokemons = {};

PokemonStore.__onDispatch = function (payload) {
  switch (payload.actionType){
    case "POKEMONS_RECEIVED":
      PokemonStore.resetPokemons(payload.pokemons);
      this.__emitChange();
      break;
    case "POKEMON_RECEIVED":
      PokemonStore.resetSinglePokemon(payload.props);
      this.__emitChange();
      break;
  }
};

PokemonStore.resetSinglePokemon = function (props) {
  _pokemons[props.id].props = props;
};

PokemonStore.resetPokemons = function (pokemons) {
  _pokemons = {};

  pokemons.forEach(function(pokemon) {
    _pokemons[pokemon.id] = pokemon;
  });
};

PokemonStore.all = function () {
  const result = [];
  for(let id in _pokemons){
    result.push(_pokemons[id]);
  }
  return result;
};

PokemonStore.find = function (id){
  return _pokemons[id];
};

window.PokemonStore = PokemonStore;

module.exports = PokemonStore;
