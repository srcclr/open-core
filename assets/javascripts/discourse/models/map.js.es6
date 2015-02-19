var Map = Discourse.Model.extend({
  results: [],
  lat: 47.6097,
  lon: -122.3331,

  setPropertiesFromJson: function(meta, results) {
    this.setProperties({
      lat: meta.lat,
      lon: meta.lon,
      results: results
    });
  }
});

export default Map;
