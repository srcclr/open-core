import ApplicationRoute from 'discourse/routes/application';
import showModal from 'discourse/lib/show-modal';

export default ApplicationRoute.reopen({
  handleShowCreateAccount: function() {
    this.transitionTo('signup');
  },

  handleShowLogin: function() {
    this.transitionTo('login');
    this.controllerFor('login').resetForm();
  },

  actions: {
    showLoginHelp: function() {
      showModal('loginHelp');
    }
  }
});
