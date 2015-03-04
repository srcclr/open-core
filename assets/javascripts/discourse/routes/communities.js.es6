export default Discourse.CommunitiesRoute = Discourse.Route.extend({
  redirect: function() { return this.redirectIfLoginRequired(); },

  model: function() {
    return DiscourseReports.Map.create({});
  },

  actions: {
    loading: function() {
      this.controllerFor('communities').set("loading", true);
      return true;
    },

    didTransition: function() {
      this.controllerFor('communities').set("loading", false);
      return true;
    }
  }
});
