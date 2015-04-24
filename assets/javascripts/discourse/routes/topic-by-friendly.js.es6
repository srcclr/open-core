export default Discourse.Route.extend({
  model: function(params) {
    return PreloadStore.getAndRemove('topic_url', function() {
      return Discourse.ajax("/" + params['part-slug'] + '/' + params['chapter-slug'] + '/' + params.slug);
    });
  },

  afterModel: function(result) {
    var path = result.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
