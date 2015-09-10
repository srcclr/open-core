export default Discourse.ProjectsRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); },

  setupController: function(controller, model) {
    this.controllerFor('application').set('showFooter', true);
  }
});
