import LoginRoute from 'discourse/routes/login'

export default LoginRoute.reopen({
  beforeModel: function() {
    var self = this;

    Discourse.ajax('/static_contents/login_page_text').then(function(result) {
      self.get('controller').set('loginPageText', result);
    });
  },

  model: function() { },

  renderTemplate: function() {
    this.render('login');
  },

  setupController: function(controller, model) {
    this.controllerFor('login').set('model', model);
  }
});
