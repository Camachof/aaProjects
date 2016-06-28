const React = require("react");
const ReactDOM = require("react-dom");
const BenchStore = require("../stores/bench_store");
const BenchActions = require("../actions/bench_actions");
const hashHistory = require('react-router').hashHistory;

const BenchMap = React.createClass({
  getInitialState: function() {
    return {
      benches: BenchStore.all()
    };
  },
  componentDidMount(){
    const mapDOMNode = ReactDOM.findDOMNode(this.refs.map);
    const mapOptions = {
      center: {lat: 37.7758, lng: -122.435}, // this is SF
      zoom: 13
    };
    this.map = new google.maps.Map(mapDOMNode, mapOptions);
    this.map.addListener(this._onMapClick);
    this.markers = [];
    BenchStore.addListener(this._updateBenches);
    this.listenForMove();
  },
  _onMapClick(coords){
    hashHistory.push({
      pathname: "benches/new",
      query: coords
    });
  },
  _updateBenches(){
    this.setState({benches: BenchStore.all()}, this._createMarkers);
  },
  componentDidUpdate() {
    this._onChange();
  },
  _onChange() {
    this.markers.forEach(mark => {
      mark.setMap(null);
    });
    this.markers = [];
  },
  _createMarkers(){
    Object.keys(this.state.benches).map((benchId) => {
      let marker = new google.maps.Marker({
        position: {
          lat: this.state.benches[benchId].lat,
          lng: this.state.benches[benchId].lng
        },
        map: this.map,
        title: this.state.benches[benchId].description,
        animation: google.maps.Animation.BOUNCE
      });
      this.markers.push(marker);
      marker.addListener("click", () => {
        alert(`clicked on: ${marker.title}`)
      });
    });
  },
  listenForMove(){
    google.maps.event.addListener(this.map, "idle", () => {
      const LatLngBounds = this.map.getBounds();
      let northEast = {lat: LatLngBounds.getNorthEast().lat(), lng: LatLngBounds.getNorthEast().lng()};
      let southWest = {lat: LatLngBounds.getSouthWest().lat(), lng: LatLngBounds.getSouthWest().lng()};
      let bounds = {southWest: southWest, northEast: northEast};
      BenchActions.fetchAllBenches(bounds);
    });
  },
  render(){
    return (<div className="map" ref="map">benchmap</div>);
  }
});

module.exports = BenchMap;
