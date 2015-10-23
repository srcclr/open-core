export default Discourse.TableOfContentsRoute = Discourse.Route.extend({
  beforeModel: function() { return this.redirectIfLoginRequired(); },

  model: function() {
    return PreloadStore.getAndRemove('guides', () => { return Discourse.ajax('/guides'); });
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  }
});
