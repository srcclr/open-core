var ZOOMS = {
  25: 10,
  50: 8,
  75: 7,
  100: 6
};

var Map = Discourse.Model.extend({
  results: [],
  lat: 47.6097,
  lon: -122.3331,
  radius: 25,

  zoomIn: Em.computed('radius', function() {
    return ZOOMS[this.get('radius')] || 7;
  }),

  setPropertiesFromJson: function(meta, results) {
    this.setProperties({
      lat: meta.lat,
      lon: meta.lon,
      results: results
    });
  }
});

export default Map;
