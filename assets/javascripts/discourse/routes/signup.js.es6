import ShowFooter from "discourse/mixins/show-footer";
import SignupRoute from 'discourse/routes/signup'

export default SignupRoute.reopen(ShowFooter, {
  controllerName: 'create_account',

  beforeModel: function() {},

  actions: {
    showRoot: function() {
      this.transitionTo('/');
    }
  }
});
