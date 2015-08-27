export default Discourse.ProjectsRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); }
});
