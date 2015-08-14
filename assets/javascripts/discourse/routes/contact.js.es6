export default Discourse.ContactRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); }
});
