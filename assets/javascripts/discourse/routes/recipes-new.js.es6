import ShowFooter from "discourse/mixins/show-footer";
import Recipe from "discourse/plugins/Discourse reports/discourse/models/recipe"

export default Discourse.RecipesNewRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() { return this.redirectIfLoginRequired(); },

  controllerName: 'recipe-form',

  beforeModel: function() {
    var self = this;

    return Discourse.ajax('/recipe_subcategories').then(function(result) {
      self.categories = result;
    });
  },

  setupController: function(controller, model) {
    controller.setProperties({ categories: this.categories, model: new Recipe });
  },

  renderTemplate: function() {
    this.render('recipe-form');
  }
});
