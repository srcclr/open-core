export default Discourse.ProjectsRoute = Discourse.Route.extend({
  redirect() { return this.redirectIfLoginRequired(); },

  model() {
    return PreloadStore.getAndRemove('projects', () => { return Discourse.ajax('/projects'); });
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  }
});
