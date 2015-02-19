export default Discourse.CommunitiesGroupsRoute = Discourse.Route.extend({
  model: function() {
    return PreloadStore.getAndRemove('meetup_groups', function() {
      return Discourse.ajax(Discourse.getURL("/communities.json"));
    });
  },

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');
    model = JSON.parse(model);

    var results = _.map(model.results, function(group) { return Em.Object.create(group); });

    map.setPropertiesFromJson(model.meta, results);

    this.render('communities', { model: map });
  }
});
