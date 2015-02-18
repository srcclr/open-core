export default Discourse.CommunitiesRoute = Discourse.Route.extend({
  model: function() {
     return PreloadStore.getAndRemove('meetup_groups', function() {
      return Discourse.ajax(Discourse.getURL("communities.json"));
    });
  },

  renderTemplate: function(data, model) {
    this.render('communities', { model: JSON.parse(model) });
  }
});
