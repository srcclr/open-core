import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.CommunitiesEventsRoute = Discourse.Route.extend({
  queryParams: {
    lat: { refreshModel: true },
    lon: { refreshModel: true },
    radius: { refreshModel: true },
    time: { refreshModel: true }
  },

  setupController: function(controller) {
    this.controllerFor('communities').set('useDateFilter', true);
  },

  beforeModel: function() {
    this.controllerFor('communities').set('aboutPage', false);
  },

  model: function(params) {
    return PreloadStore.getAndRemove('meetup_open_events', function() {
      return Discourse.ajax(UrlSanitizer.get("/open_events.json", params));
    });
  },

  afterModel: function(model, transition) {
    this.modelFor('communities').set('radius', transition.queryParams.radius || 25);
    this.controllerFor('communities').setProperties(transition.queryParams);
  },

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');

    model = JSON.parse(model);

    map.setPropertiesFromJson(
      model.meta,
      DiscourseReports.MeetupOpenEvent.createFromJson(model.results)
    )

    this.render('communities', { model: map, controller: 'communitiesEvents' });
  }
});
