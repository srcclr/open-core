import ApplicationRoute from 'discourse/routes/application';

export default ApplicationRoute.reopen({
  handleShowCreateAccount: function() {
    var self = this;

    self.send('autoLogin', 'createAccount', function(){
      self.transitionTo('/signup');
    });
  },

  handleShowLogin: function() {
    var self = this;

    this.send('autoLogin', 'login', function() {
      self.transitionTo('/login');
      self.controllerFor('login').resetForm();
    });
  },

  actions: {
    showLoginHelp: function() {
      Discourse.Route.showModal(this, 'loginHelp');
    }
  }
});
