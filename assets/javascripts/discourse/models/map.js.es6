var Map = Discourse.Model.extend({
});

Map.reopenClass({
  createFromJson: function(meta, results) {
    return Map.create({
      lat: meta.lat,
      lon: meta.lon,
      results: results
    });
  }
})

export default Map;
