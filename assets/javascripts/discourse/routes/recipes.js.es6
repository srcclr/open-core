import ShowFooter from 'discourse/mixins/show-footer';

export default Discourse.RecipesRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() { return this.redirectIfLoginRequired(); },

  model: function() {
     return PreloadStore.getAndRemove('recipes_topics', function() {
      return Discourse.ajax(Discourse.getURL("/recipes")).then(function(result) {
        return _.map(result, function(topic) {
          return Discourse.Topic.create(topic);
        })
      });
    });
  },

  setupController: function(controller, model) {
    controller.setProperties({ category: this.get('category'), model: model });
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');
      var category = Discourse.Category.findBySlug("recipes") || {};

      composerController.open({
        action: "createTopicInCategory",
        draftKey: "createRecipe",
        categoryId: category.id,
        metaData: { categorySlug: category.slug }
      });
    }
  }
});
