export default Discourse.Composer.reopen({
  isSectionTopic: Em.computed('topic.archetype', function() {
    return this.get('topic.archetype') === 'section';
  }),

  open: function(opts) {
    this._super.apply(this, arguments);
    this.setProperties({
      chapter_id: this.get('topic.chapter_id'),
      position: this.get('topic.position')
    });
  }
})
