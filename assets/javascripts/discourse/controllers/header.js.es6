import HeaderController from 'discourse/controllers/header';

export default HeaderController.reopen({
  navEasterEgg: true,

  isLoggedIn: true,
  showSignUpButton: false,

  tabletShowHeaderMenu: false,
  phoneShowHeaderMenu: false,
  phoneSearchHeaderMenu: false,

  isAdmin: Em.computed.alias('currentUser.admin'),

  actions: {
    togglePhoneSearchHeaderMenu() {
      this.set('phoneSearchHeaderMenu', !this.get('phoneSearchHeaderMenu'));
      this.set('phoneShowHeaderMenu', false);
      this.set('tabletShowHeaderMenu', false);
    },

    togglePhoneHeaderMenu() {
      this.set('phoneShowHeaderMenu', !this.get('phoneShowHeaderMenu'));
      this.set('phoneSearchHeaderMenu', false);
      this.set('tabletShowHeaderMenu', false);
    }
  }
});
