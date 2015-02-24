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
      var controller = this.get('parentView.controller');
      var params =  { radius: this.get('selectedRadius') };

      if (place && place.geometry) {
        params = {
          lat: place.geometry.location.lat(),
          lon: place.geometry.location.lng(),
          radius: this.get('selectedRadius')
        };
      }

      controller.transitionToRoute({ queryParams: params });
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
