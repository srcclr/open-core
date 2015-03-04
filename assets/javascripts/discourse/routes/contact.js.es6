import ShowFooter from "discourse/mixins/show-footer";
export default Discourse.ContactRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() { return this.redirectIfLoginRequired(); }
});
