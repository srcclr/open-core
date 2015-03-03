import ShowFooter from "discourse/mixins/show-footer";
import LoginRoute from 'discourse/routes/login'

export default LoginRoute.reopen(ShowFooter, {
  beforeModel: function() { },

  renderTemplate: function() {
    this.render('login');
  },

  setupController: function(controller, model) {
    this.controllerFor('login').set('model', model);
  }
});
