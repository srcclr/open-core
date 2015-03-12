function transitionToRoute(controller, params, place) {
  params = _.extend(params, {
    lat: place.geometry.location.lat(),
    lon: place.geometry.location.lng()
  });

  controller.transitionToRoute({ queryParams: params });
}

function getPlacePrediction(name, cb) {
  var placesAttributionElement = document.getElementById('placesAttribution');
  var autocompleteService = new google.maps.places.AutocompleteService();
  var placesService = new google.maps.places.PlacesService(placesAttributionElement);

  autocompleteService.getPlacePredictions(
    {
      input: name,
      offset: name.length,
      componentRestrictions: { country: 'us' }
    },
    function(list, status) {
      if (list && list.length > 0) {
        placesService.getDetails({ reference: list[0].reference }, cb);
      }
    }
  );
};

export default Ember.Component.extend({
  radiuses: [25, 50, 75, 100],
  selectedRadius: Em.computed('model.radius', function () {
    return this.get('model.radius');
  }),

  applyAutocomplete: Em.observer('parentView.mapIsLoaded', function() {
    if(this.get('parentView.mapIsLoaded')) {
      var input = $(this.get('element')).find('.map-search')[0];
      var autocomplete = new google.maps.places.Autocomplete(input,
        { componentRestrictions: { country: 'us' } }
      );

      this.set('autocomplete', autocomplete);
    }
  }).on('didInsertElement'),

  actions: {
    search: function() {
      var place = this.get('autocomplete').getPlace();
      var controller = this.get('parentView.controller');
      var params =  { radius: this.get('selectedRadius') };

      if (this.get('useDateFilter')) {
        params['time'] = this.get('controller.time');
      }

      if (place && place.geometry) {
        transitionToRoute(controller, params, place)
      } else {
        var input = $(this.get('element')).find('.map-search');
        var name = input.val();

        getPlacePrediction(name, function(place, status) {
          input.val(place.formatted_address);
          transitionToRoute(controller, params, place);
        })
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
