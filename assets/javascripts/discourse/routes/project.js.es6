export default Discourse.ProjectRoute = Discourse.Route.extend({
  model: function(params) {
    return Discourse.ajax("/projects/" + params.id).then((result) => {
      return result;
    })
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  }
});
