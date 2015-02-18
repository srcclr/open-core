var URL = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places';

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
      center: new google.maps.LatLng(this.get('model.lat'), this.get('model.lon')),
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

    this.get('model.results').forEach( (location) => {
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
