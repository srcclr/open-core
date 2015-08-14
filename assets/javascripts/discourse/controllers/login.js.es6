import LoginController from 'discourse/controllers/login';

export default LoginController.reopen({
  actions: {
    loginHelp: function() {
      this.send("showLoginHelp");
    }
  }
});
