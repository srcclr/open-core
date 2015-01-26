import ApplicationRoute from 'discourse/routes/application';

export default ApplicationRoute.reopen({
  actions: {
    showSignup: function() {
      this.transitionTo('/signup');
    }
  }
});
