import DiscoveryRoute from "discourse/routes/discovery";

export default DiscoveryRoute.reopen({
  actions: {
    createRecipe: function() {
      this.transitionTo('recipesNew');
    }
  }
});
