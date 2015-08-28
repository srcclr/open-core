export default Discourse.NewsletterRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); }
});
