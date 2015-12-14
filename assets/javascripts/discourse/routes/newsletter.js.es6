export default Discourse.Route.extend({
  redirect() { return this.redirectIfLoginRequired(); },

  model: function(params) {
    return PreloadStore.getAndRemove('newsletter', () => {
      return Discourse.ajax("/newsletters/" + params.id);
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  },

  activate: function() {
    Ember.$("html").addClass("newsletter");
    setTimeout(() => {
      Ember.$('.navbar__item--nwslttr').addClass('active');
    }, 0);
  },

  deactivate: function() {
    Ember.$("html").removeClass("newsletter");
    Ember.$('.navbar__item--nwslttr').removeClass('active');
  }
});
