export default Discourse.TableOfContentsRoute = Discourse.Route.extend({
  model: function() {
    return Discourse.ajax('/table-of-contents');
  },

  afterModel: function(model) {
    var path = model.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
