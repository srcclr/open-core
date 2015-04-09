var CREATE_BLOG = 'createBlog';
var CREATE_TOPIC_IN_CATEGORY = 'createTopicInCategory';
var CREATE_RECIPE = 'createRecipe';
var ARCHETYPES = { 'createBlog': 'blog', 'createRecipe': 'recipe' };

export default Discourse.Composer.reopen({
  creatingBlog: Em.computed.equal('action', CREATE_BLOG),
  creatingTopicInCategory: Em.computed.equal('action', CREATE_TOPIC_IN_CATEGORY),
  creatingRecipe: Em.computed.equal('action', CREATE_RECIPE),

  canEditTitle: Em.computed.or('creatingTopic', 'creatingPrivateMessage', 'editingFirstPost', 'creatingTopicInCategory', 'creatingBlog', 'creatingRecipe'),
  cantEditCategory: Em.computed.or('privateMessage', 'creatingTopicInCategory', 'creatingBlog', 'creatingRecipe'),

  isSectionTopic: Em.computed('topic.archetype', function() {
    return this.get('topic.archetype') === 'section';
  }),

  saveIcon: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_TOPIC_IN_CATEGORY: return '<i class="fa fa-plus"></i>';
      case CREATE_BLOG: return '<i class="fa fa-plus"></i>';
      case CREATE_RECIPE: return '<i class="fa fa-plus"></i>';
    }})()
  }.property('action'),

  saveText: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_TOPIC_IN_CATEGORY: return I18n.t('composer.create_' + self.get('categorySlug'));
      case CREATE_BLOG: return I18n.t('composer.create_blog');
      case CREATE_RECIPE: return I18n.t('composer.create_recipe');
    }})()
  }.property('action'),

  actionTitle: function() {
    var self = this;

    return this._super() || (function() { switch (self.get('action')) {
      case CREATE_TOPIC_IN_CATEGORY: return I18n.t('topic.new_' + self.get('categorySlug'));
      case CREATE_BLOG: return I18n.t('topic.new_blog');
      case CREATE_RECIPE: return I18n.t('topic.new_recipe');
    }})()
  }.property('action'),

  open: function(opts) {
    this._super.apply(this, arguments);
    this.setupArchetype();

    this.setProperties({
      chapter_id: this.get('topic.chapter_id'),
      position: this.get('topic.position'),
      categorySlug: (opts.metaData || {}).categorySlug
    });
  },

  setupArchetype: function() {
    this.set('archetype', ARCHETYPES[this.get('action')] || 'regular');
  }
})
