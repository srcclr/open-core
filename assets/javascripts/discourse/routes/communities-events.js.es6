import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.CommunitiesEventsRoute = Discourse.Route.extend({
  queryParams: {
    lat: { refreshModel: true },
    lon: { refreshModel: true },
    radius: { refreshModel: true }
  },

  model: function(params) {
     return PreloadStore.getAndRemove('meetup_open_events', function() {
      return Discourse.ajax(UrlSanitizer.get("/open_events.json", params));
    });
  },

  afterModel: function(model, transition) {
    this.modelFor('communities').set('radius', transition.queryParams.radius || 25);
  },

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');

    model = JSON.parse(model);

    map.setPropertiesFromJson(
      model.meta,
      DiscourseReports.MeetupOpenEvent.createFromJson(model.results)
    )

    this.render('communities', { model: map, controller: 'communitiesEvents' });
  },

  actions: {
    loading: function() {
      this.controllerFor('communitiesEvents').set("loading", true);
      return true;
    },

    didTransition: function() {
      this.controllerFor('communitiesEvents').set("loading", false);
      return true;
    }
  }
});
