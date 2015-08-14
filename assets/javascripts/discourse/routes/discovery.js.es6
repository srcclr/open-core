import DiscoveryRoute from "discourse/routes/discovery";

export default DiscoveryRoute.reopen({
  beforeModel: function(transition) {
    this.controllerFor('discovery').set('isHomepage', transition.intent.url === "/");
  },

  actions: {
    willTransition: function(transition) {
      this.controller.set('isHomepage', transition.intent.url === "/");
    }
  }
});
