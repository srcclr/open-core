export default Ember.Controller.extend({
  title: Ember.computed('model.title', function() {
    return this.get('model.title');
  }),

  cooked: Ember.computed('model.post_stream', function() {
    return (_.first(this.get('model.post_stream')) || {}).cooked;
  }),
});
