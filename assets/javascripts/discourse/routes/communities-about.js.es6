import ShowFooter from "discourse/mixins/show-footer";
import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.CommunitiesAboutRoute = Discourse.Route.extend(ShowFooter, {
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

  renderTemplate: function(data, model) {
    var map = this.modelFor('communities');
    model = JSON.parse(model);

    var results = _.map(model.results, function(group) { return Em.Object.create(group); });

    map.setPropertiesFromJson(model.meta, results);

    this.render('communities/about', { outlet: 'results', model: model, controller: 'communitiesAbout' });
  },
});
