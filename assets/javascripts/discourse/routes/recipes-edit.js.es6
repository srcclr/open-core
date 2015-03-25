import ShowFooter from "discourse/mixins/show-footer";
import Recipe from "discourse/plugins/Discourse reports/discourse/models/recipe"

export default Discourse.RecipesEditRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() { return this.redirectIfLoginRequired(); },

  controllerName: 'recipe-form',

  model: function(params) {
    return PreloadStore.getAndRemove('recipe_' + params.id , function() {
      return Discourse.ajax("/recipes/" + params.id +"/edit.json");
    });
  },

  setupController: function(controller, model) {
    var recipe = Recipe.edit(model);
    recipe.setLanguagesAndTechnologies(
      controller.get('languages'),
      controller.get('technologies')
    )

    controller.setProperties({ categories: model.categories, model: recipe });
  },

  renderTemplate: function() {
    this.render('recipe-form');
  }
});
