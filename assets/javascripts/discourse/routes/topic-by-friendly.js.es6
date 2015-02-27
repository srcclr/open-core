import Topic from 'discourse/models/topic';

export default Discourse.Route.extend({
  model: function(params) {
    return Topic.idForSlug(params.slug);
  },

  afterModel: function(result) {
    var path = result.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
