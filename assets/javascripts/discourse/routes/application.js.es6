import ApplicationRoute from 'discourse/routes/application';

export default ApplicationRoute.reopen({
  handleShowCreateAccount: function() {
    this.transitionTo('signup');
  },

  handleShowLogin: function() {
    this.transitionTo('login');
    this.controllerFor('login').resetForm();
  },
});
