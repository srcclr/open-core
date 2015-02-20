export default Ember.Component.extend({
  radiuses: [25, 50, 75, 100],
  selectedRadius: Em.computed('model.radius', function () {
    return this.get('model.radius');
  }),

  applyAutocomplete: Em.observer('parentView.mapIsLoaded', function() {
    if(this.get('parentView.mapIsLoaded')) {
      var input = $(this.get('element')).find('.map-search')[0];
      var autocomplete = new google.maps.places.Autocomplete(input, { componentRestrictions: { country: 'us' } });

      this.set('autocomplete', autocomplete);
    }
  }).on('didInsertElement'),

  actions: {
    search: function() {
      var place = this.get('autocomplete').getPlace();

      if (place && place.geometry) {
        this.setProperties({
          'model.lat': place.geometry.location.lat(),
          'model.lon': place.geometry.location.lng(),
          'model.radius': this.get('selectedRadius')
        });
      } else {
        this.set('model.radius', this.get('selectedRadius'));
      }
    }
  },

  radiusView: Em.View.extend({
    tagName: 'li',
    classNameBindings: ['active'],
    template: Ember.Handlebars.compile(
      "<a {{action 'updateRadius' target='view'}}>{{view.radius}} miles</a>"
    ),

    active: Em.computed('selectedRadius', function() {
      return this.get('selectedRadius')  === this.radius;
    }),

    actions: {
      updateRadius: function() {
        this.set('selectedRadius', this.get('radius'))
      }
    }
  })
});
