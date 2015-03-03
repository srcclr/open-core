import ShowFooter from "discourse/mixins/show-footer";
export default Discourse.CommunityRequestRoute = Discourse.Route.extend(ShowFooter, {
  model: function() {
    return Discourse.User.current().findDetails();
  },
});
