export default Discourse.CommunitiesAboutRoute = Discourse.Route.extend({
  afterModel: function(model, transition) {
    this.controllerFor('communities').set('aboutPage', true);
  },

  renderTemplate: function(data, model) {
    this.render('communities');
  },
});
