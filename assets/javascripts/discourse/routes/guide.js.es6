export default Discourse.GuideRoute = Discourse.Route.extend({
  model: function(params) {
    return Discourse.ajax("/guides/" + params.slug);
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  }
});
