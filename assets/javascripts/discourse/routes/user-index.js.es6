import UserIndexRoute from 'discourse/routes/user-index'

export default UserIndexRoute.reopen({
  beforeModel: function() { },

  setupController: function(controller, user) {
    controller.setProperties({
      model: user,
      viewRenderedAt: (Date.parse(new Date))
    });
  }
});
