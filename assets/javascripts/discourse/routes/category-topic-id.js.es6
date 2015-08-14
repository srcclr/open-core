export default Discourse.Route.extend({
  beforeModel: function(transition) {
    var params = transition.params.categoryTopicId;

    if (Discourse.Category.findBySlug(params.slug, params.category_slug)) {
      this.transitionTo('discovery.category', params.category_slug, params.slug);
    }
  },

  model: function(params) {
    return PreloadStore.getAndRemove('topic_url', function() {
      return Discourse.Topic.idForSlugInCategory(params.slug, params.category_slug);
    });
  },

  afterModel: function(result) {
    var path = result.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
