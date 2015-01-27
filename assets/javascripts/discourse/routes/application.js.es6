import ApplicationRoute from 'discourse/routes/application';

export default ApplicationRoute.reopen({
  actions: {
    showSignup: function() {
      this.transitionTo('/signup');
    }
  },

  handleShowLogin: function() {
    var self = this;

    this.send('autoLogin', 'login', function() {
      self.transitionTo('/login');
      self.controllerFor('login').resetForm();
    });
  },
});
