export default Discourse.SupportersRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); }
});
