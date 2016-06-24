module.exports = {
  fetchAllPokemons: function (callback) {
    $.ajax({
      method: "GET",
      url: "/api/pokemon",
      dataType: "json",
      success(response){
        callback(response);
      }
    });
  },

  fetchPokemon: function (id, callback) {
    $.ajax({
      method: "GET",
      url: `/api/pokemon/${id}`,
      dataType: "json",
      success(response){
        callback(response);
      }
    });
  }
};
