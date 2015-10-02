export default Discourse.NewsletterRoute = Discourse.Route.extend({
  redirect() { return this.redirectIfLoginRequired(); },

  model: function() {
    return Discourse.ajax("/newsletters");
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  },

  activate: function() {
    Ember.$('html').addClass('newsletter');
  },

  deactivate: function() {
    Ember.$('html').removeClass('newsletter');
  }
});
