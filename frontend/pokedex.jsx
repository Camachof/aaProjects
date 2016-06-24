const React = require("react");
const ReactDOM = require("react-dom");
const ApiUtil = require("./util/api_utils.js");
const PokemonAction = require("./actions/pokemon_actions.js");
const PokemonStore = require("./stores/pokemon.js");
const PokemonsIndex = require("./components/pokemons_index.jsx");
const ReactRouter = require('react-router');
const App = require("./components/app.jsx");
const PokemonDetail = require("./components/pokemon_detail.jsx");
const ToyDetail = require("./components/toy_detail.jsx");
const ToysIndex = require("./components/toys_index.jsx");

const Router = ReactRouter.Router;
const Route = ReactRouter.Route;
const IndexRoute = ReactRouter.IndexRoute;
const hashHistory = ReactRouter.hashHistory;

const routes = (
  <Route path="/" component={App}>
    <Route path="pokemon/:pokemonId" component={PokemonDetail}>
      <Route path="toys/:toyId" component={ToyDetail}/>
    </Route>
  </Route>
);

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(
    <Router history={hashHistory}>{routes}</Router>,
    document.getElementById("root")
  );
});

//Note to self: pokemon.js (store) and pokemon actions have window methods defined on them
