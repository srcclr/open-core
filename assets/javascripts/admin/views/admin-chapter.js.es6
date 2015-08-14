export default Discourse.AdminChapterView = Discourse.View.extend({
  classNameBindings: [':chapter'],

  _focusOnEdit: function() {
    if (this.get('controller.editing')) {
      Ember.run.scheduleOnce('afterRender', this, '_focusName');
    }
  }.observes('controller.editing').on('didInsertElement'),

  _focusName: function() {
    $('.chapter-name').select();
  }
});
