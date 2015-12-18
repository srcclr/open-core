import Project from "../models/project"

export default Discourse.ProjectRoute = Discourse.Route.extend({
  model: function(params) {
    return Discourse.ajax("/projects/" + params.id).then((project) => {
      return Project.createFromJson(project);
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
