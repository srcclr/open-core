Discourse.DiscoveryHomepageRoute = Discourse.Route.extend({
  model: function() {
    return PreloadStore.getAndRemove('homepage', function() {
      return Discourse.ajax(Discourse.getURL("homepage.json"));
    });
  },

  renderTemplate: function(data, topic) {
    this.render('homepage', { model: topic, controller: 'homepage' });
  }
});

export default Discourse.HomepageReportsRoute
