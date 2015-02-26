import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.CommunitiesGroupsRoute = Discourse.Route.extend({
  queryParams: {
    lat: { refreshModel: true },
    lon: { refreshModel: true },
    radius: { refreshModel: true }
  },

  setupController: function(controller) {
    this.controllerFor('communities').set('useDateFilter', false);
  },

  model: function(params) {
    return PreloadStore.getAndRemove('meetup_groups', function() {
      return Discourse.ajax(UrlSanitizer.get("/communities.json", params));
    });
  },

  afterModel: function(model, transition) {
    this.modelFor('communities').set('radius', transition.queryParams.radius || 25);
    this.controllerFor('communities').setProperties(transition.queryParams);
  },

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');
    model = JSON.parse(model);

    var results = _.map(model.results, function(group) { return Em.Object.create(group); });

    map.setPropertiesFromJson(model.meta, results);

    this.render('communities/results', { outlet: 'results', model: map, controller: 'communitiesGroups' });
  }
});
