export default Discourse.DiscoveryHomepageRoute = Discourse.Route.extend({
  model: function() {
    return PreloadStore.getAndRemove('homepage_topics', function() {
      return Discourse.ajax(Discourse.getURL("homepage.json"));
    });
  },

  renderTemplate: function(data, topics) {
    var topics = _.map(
      topics,
      function(topic) {
        var t = Discourse.Topic.create(topic);
        t.category = Discourse.Category.create(topic.category);

        return t;
      }
    );

    this.render('homepage', { model: topics, controller: 'homepage' });
  }
});
