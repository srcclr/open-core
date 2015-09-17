export default Discourse.ProjectsRoute = Discourse.Route.extend({
  redirect() { return this.redirectIfLoginRequired(); },

  setupController(controller, model) {
    this.controllerFor('application').set('showFooter', true);
  }
});
