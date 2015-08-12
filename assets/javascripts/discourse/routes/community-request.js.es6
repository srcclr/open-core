export default Discourse.CommunityRequestRoute = Discourse.Route.extend({
  beforeModel: function() { return this.redirectIfLoginRequired(); },

  model: function() {
    return Discourse.User.current().findDetails();
  },

  setupController: function(controller, model) {
    controller.set('model', model);
    Discourse.ajax('/static_contents/request_community_page_text').then(function(result) {
      controller.set('requestCommunityText', result);
    });
  },
});
