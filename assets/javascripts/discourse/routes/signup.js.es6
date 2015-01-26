import SignupRoute from 'discourse/routes/signup'

export default SignupRoute.reopen({
  controllerName: 'create_account',

  beforeModel: function() {}
});
