export default Discourse.NewsletterRoute = Discourse.Route.extend({
  redirect() { return this.redirectIfLoginRequired(); },

  model: function() {
    return Discourse.ajax("/newsletter_archives");
  },

  setupController(controller, model) {
    controller.set('model', model);
    this.controllerFor('application').set('showFooter', true);
  },

  activate: function() {
    Ember.$('body').addClass('newsletter');
  },

  deactivate: function() {
    Ember.$('body').removeClass('newsletter');
  }
});
