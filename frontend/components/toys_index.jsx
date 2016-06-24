const React = require("react");

const ToysIndex = React.createClass({

  render () {
    let result;

    if (this.props.toys.length > 0){
      result = (
        this.props.toys.map(function(toy){
          return (<ToyIndexItem key={toy.id} toy={toy}/>);
        })
      );
    }

    return (
      <ul>
        {result}
      </ul>
    );
  }
});

module.exports = ToysIndex;
