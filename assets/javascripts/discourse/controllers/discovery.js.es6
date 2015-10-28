import DiscoveryController from "discourse/controllers/discovery";

export default DiscoveryController.reopen({
  isHomepage: false,

  _showFooter: function() {
    this.set("controllers.application.showFooter", this.get("isHomepage") || this.get("loadedAllItems"));
  }.observes("loadedAllItems")
})
