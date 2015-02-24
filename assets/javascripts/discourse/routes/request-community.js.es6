export default Discourse.RequestCommunityRoute = Discourse.Route.extend({
  model: function() {
    return Discourse.User.current().findDetails();
  },
});
