import ShowFooter from "discourse/mixins/show-footer";
export default Discourse.CommunityRequestRoute = Discourse.Route.extend(ShowFooter, {
  beforeModel: function() { return this.redirectIfLoginRequired(); },

  model: function() {
    return Discourse.User.current().findDetails();
  },
});
