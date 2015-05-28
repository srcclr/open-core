export default Discourse.TableOfContentsRoute = Discourse.Route.extend({
  beforeModel: function() { return this.redirectIfLoginRequired(); },

  model: function() {
    return Discourse.ajax('/table-of-contents');
  },

  afterModel: function(model) {
    var path = model.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
