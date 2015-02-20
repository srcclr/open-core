export default Ember.Component.extend({
  radiuses: [25, 50, 75, 100],
  selectedRadius: 25,

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
