export default Discourse.Route.extend({
  model: function(params) {
    return Discourse.Topic.idForSlug(params.slug);
  },

  afterModel: function(result) {
    var path = result.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
