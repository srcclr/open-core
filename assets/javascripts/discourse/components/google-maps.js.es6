export default Ember.Component.extend({
  classNames: ['communities-map'],
  markers: [],

  mapCenter: Em.computed('model.lat', 'model.lon', function() {
    return new google.maps.LatLng(this.get('model.lat'), this.get('model.lon'));
  }),

  mapOptions: function () {
    return {
      center: this.get('mapCenter'),
      zoom: this.get('model.initialZoom'),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false
    }
  },

  insertMap: Em.observer('parentView.mapIsLoaded', function() {
    if(this.get('parentView.mapIsLoaded')) {
      this.set('map', new google.maps.Map(this.get('element'), this.mapOptions()));
      this.showMarkers();
    }
  }).on('didInsertElement'),

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

  updateCenter: Em.observer('model.radius', 'mapCenter', function() {
    this.get('map').panTo(this.get('mapCenter'));
    this.get('map').setZoom(this.get('model.zoomIn'));
  }),

  clearMarkers: function() {
    this.get('markers').forEach(function(marker) {
      marker.setMap(null);
    });
  }
});
