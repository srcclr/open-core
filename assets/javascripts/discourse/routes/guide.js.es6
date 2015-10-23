export default Discourse.GuideRoute = Discourse.Route.extend({
  model: function(params) {
    return Discourse.ajax("/guides/" + params.slug).then((result) => {
      return result.part;
    })
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  },

  activate() {
    setTimeout(() => {
      Ember.$('.navbar__item--guides').addClass('active');
    }, 0);
  },

  deactivate() {
    Ember.$('.navbar__item--guides').removeClass('active');
  }
});
