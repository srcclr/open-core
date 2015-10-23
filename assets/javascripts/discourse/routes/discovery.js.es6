import DiscoveryRoute from "discourse/routes/discovery";

export default DiscoveryRoute.reopen({
  beforeModel(transition) {
    this.controllerFor('discovery').set('isHomepage', transition.targetName === "discovery.homepage");
  },

  actions: {
    willTransition(transition) {
      this.controller.set('isHomepage', transition.targetName === "discovery.homepage");
    }
  }
});
