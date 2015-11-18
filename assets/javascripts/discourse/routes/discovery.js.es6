import DiscoveryRoute from "discourse/routes/discovery";

export default DiscoveryRoute.reopen({
  beforeModel(transition) {
    this.controllerFor('discovery').set('isHomepage', transition.targetName === "discovery.homepage");
  },

  actions: {
    willTransition(transition) {
      this.controller.set('isHomepage', transition.targetName === "discovery.homepage");

      if ([
            "discovery.latest", "discovery.new", "discovery.unread", "discovery.top", "discovery.categories",
            "discovery.parentCategory", "discovery.newCategory", "discovery.unreadCategory",
            "discovery.topCategory", "discovery.latestCategory"
          ].indexOf(transition.targetName) > -1) {
        setTimeout(() => {
          Ember.$('.navbar__item--discussions').addClass('active');
        }, 500);
      } else {
        Ember.$('.navbar__item--discussions').removeClass('active');
      }
    }
  },

  activate() {
    if (this.controller === undefined && location.pathname != "/") {
      setTimeout(() => {
        Ember.$('.navbar__item--discussions').addClass('active');
      }, 500);
    }
  }
});
