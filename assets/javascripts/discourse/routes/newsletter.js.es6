export default Discourse.NewsletterRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); },

  setupController: function(controller, model) {
    this.controllerFor('application').set('showFooter', true);
  },
});
