var CREATE_BLOG = 'createBlog';
var CREATE_TOPIC_IN_CATEGORY = 'createTopicInCategory';
var ARCHETYPES = { 'blogs': 'blog', 'recipes': 'recipe' };

export default Discourse.Composer.reopen({
  creatingTopicInCategory: Em.computed.equal('action', CREATE_TOPIC_IN_CATEGORY),

  canEditTitle: Em.computed.or('creatingTopic', 'creatingPrivateMessage', 'editingFirstPost', 'creatingTopicInCategory'),
  cantEditCategory: Em.computed.or('privateMessage', 'creatingTopicInCategory'),

  isSectionTopic: Em.computed('topic.archetype', function() {
    return this.get('topic.archetype') === 'section';
  }),

  saveIcon: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_TOPIC_IN_CATEGORY: return '<i class="fa fa-plus"></i>';
    }})()
  }.property('action'),

  saveText: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_TOPIC_IN_CATEGORY: return I18n.t('composer.create_' + self.get('categorySlug'));
    }})()
  }.property('action'),

  actionTitle: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_TOPIC_IN_CATEGORY: return I18n.t('topic.new_' + self.get('categorySlug'));
    }})()
  }.property('action'),

  open: function(opts) {
    this._super.apply(this, arguments);

    this.setProperties({
      chapter_id: this.get('topic.chapter_id'),
      parent_topic_id: this.get('parent_topic_id'),
      position: this.get('topic.position'),
      categorySlug: (opts.metaData || {}).categorySlug
    });

    this.setupArchetype();
  },

  setupArchetype: function() {
    this.set('archetype', ARCHETYPES[this.get('categorySlug')] || 'regular');
  }
})
