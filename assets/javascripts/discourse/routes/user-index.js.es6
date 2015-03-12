import UserIndexRoute from 'discourse/routes/user-index'
import ShowFooter from "discourse/mixins/show-footer";

export default UserIndexRoute.reopen(ShowFooter, {
  beforeModel: function() { },

  setupController: function(controller, user) {
    controller.setProperties({
      model: user,
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
