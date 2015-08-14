export default Discourse.AdminPartView = Em.View.extend({
  classNameBindings: [':part'],

  _focusOnEdit: function() {
    if (this.get('controller.editing')) {
      Ember.run.scheduleOnce('afterRender', this, '_focusName');
    }
  }.observes('controller.editing').on('didInsertElement'),

  _focusName: function() {
    $('.part-name').select();
  }
});
