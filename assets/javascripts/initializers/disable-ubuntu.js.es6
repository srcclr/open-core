export default {
  initialize: function () {
    var login_methods = Em.get("Discourse.LoginMethod.all");

    login_methods.removeObject(login_methods.findBy('name', 'ubuntu'));
  }
};
