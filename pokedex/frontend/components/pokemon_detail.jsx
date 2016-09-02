const React = require("react");
const PokemonStore = require("../stores/pokemon.js");
const PokemonAction = require("../actions/pokemon_actions.js");

const PokemonDetail = React.createClass({
  getInitialState(){
    return {pokemon: this.getStateFromStore()};
  },

  getStateFromStore(){
    return PokemonStore.find(parseInt(this.props.params.pokemonId));
  },

  componentWillMount(){
    this.listener = PokemonStore.addListener(this.onChange);
  },

  onChange(){
    this.setState({pokemon: this.getStateFromStore()});
  },

  componentWillReceiveProps(props){
    PokemonAction.fetchPokemon(props.params.pokemonId);
  },

  componentWillUnmount(){
    this.listener.remove();
  },

  render () {
    let result;

    if (this.state.pokemon === undefined) {
      result = <div></div>;
    } else {
      result = (
        <div>
          Attack: {this.state.pokemon.attack}
          <br/> Defense: {this.state.pokemon.defense}
          <img src={this.state.pokemon.image_url}/>
        </div>
      );
    }

    return(
      <div>
        <div className="pokemon-detail-pane">
          <div className="detail">
            {result}
          </div>
        </div>
        {this.props.children}
      </div>
    );
  }
});

module.exports = PokemonDetail;
