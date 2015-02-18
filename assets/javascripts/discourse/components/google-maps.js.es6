var URL = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places';
var MODEL = Em.Object.create({
  lat: 47.6062100,
  lon: -122.3320700,
  results: [
    { name: 'Bellingham', lat: 48.7502, lon: -122.4750 },
    { name: 'Tacoma', lat: 47.2414, lon: -122.4594 }
  ]
});

export default Ember.Component.extend({
  classNames: ['communities-map'],
  markers: [],

  loadMap: function() {
    if (typeof google === "undefined" || typeof google.maps === "undefined") {
      var self = this;
      window.mapLoadCallback = function() { self.insertMap(); }
      $.getScript(URL + '&callback=mapLoadCallback');
    } else {
      this.insertMap();
    }
  }.on('didInsertElement'),

  mapOptions: function () {
    return {
      center: new google.maps.LatLng(MODEL.lat, MODEL.lon),
      zoom: 7,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
  },

  insertMap: function() {
    this.set('map', new google.maps.Map(this.get('element'), this.mapOptions()));
    this.showMarkers();
  },

  showMarkers: function() {
    this.clearMarkers();
    var markers = [];

    MODEL.results.forEach( (location) => {
      markers.push(new google.maps.Marker({
        position: new google.maps.LatLng(location.lat, location.lon),
        map: this.get('map'),
        title: location.name
      }));
    });

    this.set('markers', markers);
  },

  clearMarkers: function() {
    this.get('markers').forEach(function(marker) {
      marker.setMap(null);
    });
  }
});
