import HeaderController from 'discourse/controllers/header';

export default HeaderController.reopen({
  needs: ['application', 'login'],

  actions: {
    externalLogin(provider) {
      this.get('controllers.login').send('externalLogin', provider);
    }
  }
})
