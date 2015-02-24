import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.CommunitiesGroupsRoute = Discourse.Route.extend({
  queryParams: {
    lat: { refreshModel: true },
    lon: { refreshModel: true },
    radius: { refreshModel: true }
  },

  model: function(params) {
    return PreloadStore.getAndRemove('meetup_groups', function() {
      return Discourse.ajax(UrlSanitizer.get("/communities.json", params));
    });
  },

  afterModel: function(model, transition) {
    if (transition.queryParams.radius) {
      this.modelFor('communities').set('radius', transition.queryParams.radius);
    }
  },

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');
    model = JSON.parse(model);

    var results = _.map(model.results, function(group) { return Em.Object.create(group); });

    map.setPropertiesFromJson(model.meta, results);

    this.render('communities', { model: map, controller: 'communitiesGroups' });
  },

  actions: {
    loading: function() {
      this.controllerFor('communitiesGroups').set("loading", true);
      return true;
    },

    didTransition: function() {
      this.controllerFor('communitiesGroups').set("loading", false);
      return true;
    }
  }
});
