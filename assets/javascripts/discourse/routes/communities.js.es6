export default Discourse.CommunitiesRoute = Discourse.Route.extend({
  model: function() {
     return PreloadStore.getAndRemove('meetup_groups', function() {
      return Discourse.ajax(Discourse.getURL("communities.json"));
    });
  },

  renderTemplate: function(data, model) {
    model = JSON.parse(model);
    this.render(
      'communities',
      { model: DiscourseReports.Map.createFromJson(model.meta, model.results) }
    );
  }
});
