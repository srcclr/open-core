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

  mapCenter: Em.computed('model.lat', 'model.lon', function() {
    return new google.maps.LatLng(this.get('model.lat'), this.get('model.lon'));
  }),

  mapOptions: function () {
    return {
      center: this.get('mapCenter'),
      zoom: 7,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
  },

  insertMap: function() {
    this.set('map', new google.maps.Map(this.get('element'), this.mapOptions()));
    this.showMarkers();
  },

  showMarkers: Em.observer('model.results', function() {
    var markers = [];
    this.clearMarkers();

    this.get('model.results').forEach( (location) => {
      markers.push(new google.maps.Marker({
        position: new google.maps.LatLng(location.get('lat'), location.get('lon')),
        map: this.get('map'),
        title: location.get('name')
      }));
    });

    this.set('markers', markers);
  }),

  updateCenter: Em.observer('mapCenter', function() {
    this.get('map').setCenter(this.get('mapCenter'));
  }),

  clearMarkers: function() {
    this.get('markers').forEach(function(marker) {
      marker.setMap(null);
    });
  }
});
