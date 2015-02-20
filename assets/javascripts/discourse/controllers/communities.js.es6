export default Ember.Controller.extend({
  queryParams: ['lat', 'lon', 'radius'],

  loading: false,

  refreshPath: Em.observer('lat', 'lon', 'radius', function() {
    this.transitionToRoute({ queryParams: this.getProperties('lat', 'lon', 'radius')});
  })
});
