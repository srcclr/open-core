import UserIndexRoute from 'discourse/routes/user-index'
import ShowFooter from "discourse/mixins/show-footer";

export default UserIndexRoute.reopen(ShowFooter, {
  beforeModel: function() { },

  setupController: function(controller, user) {
    controller.setProperties({
      model: user,
      viewRenderedAt: (Date.parse(new Date))
    });
  }
});
