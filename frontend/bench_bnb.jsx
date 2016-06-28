const React = require("react");
const ReactDOM = require("react-dom");
const BenchForm = require("./components/bench_form");
const Search = require("./components/search");

const ReactRouter = require('react-router');
const Router = ReactRouter.Router;
const Route = ReactRouter.Route;
const IndexRoute = ReactRouter.IndexRoute;
const hashHistory = ReactRouter.hashHistory;

const App = React.createClass({
  render(){
    return(
      <div>
        {this.props.children}
      </div>
    );
  }
});

const appRouter = (
  <Router history={hashHistory} >
    <Route path="/" component={App}>
      <IndexRoute component={Search} />
      debugger;
      <Route path="benches/new" component={BenchForm} />
    </Route>
  </Router>
);

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(appRouter, document.getElementById("content"));
});
