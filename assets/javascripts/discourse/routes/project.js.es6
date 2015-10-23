export default Discourse.ProjectRoute = Discourse.Route.extend({
  model: function(params) {
    return Discourse.ajax("/projects/" + params.id).then((result) => {
      return result;
    })
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  },

  activate() {
    setTimeout(() => {
      Ember.$('.navbar__item--projects').addClass('active');
    }, 0);
  },

  deactivate() {
    Ember.$('.navbar__item--projects').removeClass('active');
  }
});
