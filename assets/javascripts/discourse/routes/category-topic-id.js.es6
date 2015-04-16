export default Discourse.Route.extend({
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
