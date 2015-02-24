export default Discourse.CommunityRequestRoute = Discourse.Route.extend({
  model: function() {
    return Discourse.User.current().findDetails();
  },
});
