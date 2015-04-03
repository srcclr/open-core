var CREATE_BLOG = 'createBlog';

export default Discourse.Composer.reopen({
  creatingTopic: Em.computed.equal('action', CREATE_BLOG),
  canEditTitle: Em.computed.or('creatingTopic', 'creatingPrivateMessage', 'editingFirstPost', 'creatingBlog'),

  isSectionTopic: Em.computed('topic.archetype', function() {
    return this.get('topic.archetype') === 'section';
  }),

  saveIcon: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_BLOG: return '<i class="fa fa-plus"></i>';
    }})()
  }.property('action'),

  saveText: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_BLOG: return I18n.t('composer.create_blog');
    }})()
  }.property('action'),

  actionTitle: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_BLOG: return I18n.t('topic.new_blog');
    }})()
  }.property('action'),

  open: function(opts) {
    this._super.apply(this, arguments);
    this.setupArchetype();

    this.setProperties({
      chapter_id: this.get('topic.chapter_id'),
      position: this.get('topic.position')
    });
  },

  setupArchetype: function() {
    if (this.get('action') === CREATE_BLOG) {
      this.set('archetype', 'blog');
    }
  }
})
