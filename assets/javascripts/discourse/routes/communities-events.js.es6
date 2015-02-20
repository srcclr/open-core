export default Discourse.CommunitiesEventsRoute = Discourse.Route.extend({
  queryParams: {
    lat: { refreshModel: true },
    lon: { refreshModel: true },
    radius: { refreshModel: true }
  },

  model: function() {
     return PreloadStore.getAndRemove('meetup_open_events', function() {
      return Discourse.ajax(Discourse.getURL("/open_events.json"));
    });
  },

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');

    model = JSON.parse(model);

    map.setPropertiesFromJson(
      model.meta,
      DiscourseReports.MeetupOpenEvent.createFromJson(model.results)
    )

    this.render('communities', { model: map });
  }
});
