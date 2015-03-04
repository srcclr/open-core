import ShowFooter from "discourse/mixins/show-footer";
export default Discourse.SupportersRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() { return this.redirectIfLoginRequired(); }
});
