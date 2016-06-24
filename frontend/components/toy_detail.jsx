const React = require("react");
const PokemonStore = require("../stores/pokemon.js");

const ToyDetail = React.createClass({
  getInitialState(){
    const pokemon = this.getStateFromStore();
    if (pokemon === undefined){
      return {toy: null};
    } else {
      return {toy: pokemon.toy};
    }
  },

  getStateFromStore(){
    return PokemonStore.find(this.props.params.pokemonId);
  },

  _onChange(){
    this.setState({toy: this.getStateFromStore(this.props.params.pokemonId).toy}, console.log(this.getStateFromStore(this.props.params.pokemonId)));
    console.log("UPDATE DETECTED");
  },

  componentDidMount(){
    this.listener = PokemonStore.addListener(this._onChange);
  },

  componentWillUnmount(){
    this.listener.remove();
  },

  componentWillReceiveProps(){
    this._onChange();
  },

  render(){
    return(
      <div> TESTING</div>
    );
  }
});

module.exports = ToyDetail;
