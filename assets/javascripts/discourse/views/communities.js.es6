import Communities from 'discourse/views/static'

var URL = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places';

export default Communities.extend({
  templateName: 'communities',
  mapIsLoaded: false,

  loadMap: function() {
    if (typeof google === "undefined" || typeof google.maps === "undefined") {
      var self = this;
      window.mapLoadCallback = function() { self.set('mapIsLoaded', true); }
      $.getScript(URL + '&callback=mapLoadCallback');
    } else {
      self.set('mapIsLoaded', true);
    }
  }.on('didInsertElement')
});
