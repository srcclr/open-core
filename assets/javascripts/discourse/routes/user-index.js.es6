import UserIndexRoute from 'discourse/routes/user-index'

export default UserIndexRoute.reopen({
  beforeModel: function() { },

  setupController: function(controller, model) {
    controller.setProperties({
      model: model,
      viewRenderedAt: (Date.parse(new Date))
    });
  },

  actions: {
    didTransition: function() {
      var user = this.controller.get('model');

      if (Discourse.SiteSettings.enable_stackexchange_logins) {
        Discourse.ajax('/stackexchange/identificator.json').then(function(result) {
          if(result.uid) { user.set('hasStackExchange', true); }
        });
      }
    }
  }
});
