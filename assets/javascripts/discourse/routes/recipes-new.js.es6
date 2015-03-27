import ShowFooter from "discourse/mixins/show-footer";
import Recipe from "discourse/plugins/Discourse reports/discourse/models/recipe"
import { cleanTag } from 'discourse/plugins/Discourse reports/discourse/mixins/recipe-languages-technologies'

function prepareTags(tags) {
  return _.map(tags, cleanTag);
}

function defaultCategory(categories) {
  var defaultCategory = Discourse.SiteSettings.recipe_category_default;

  var category = _.find(
    categories,
    function (category) { return category.name.toLowerCase() === defaultCategory.toLowerCase() }
  );

  return category && category.id;
}

function defaultValues(categories) {
  return {
    topic: Em.Object.create({ title: Discourse.SiteSettings.recipe_title_default, category: defaultCategory(categories) }),
    post: Em.Object.create({ raw: Discourse.SiteSettings.recipe_anotation_default }),
    languages: prepareTags(Discourse.SiteSettings.recipe_languages_default.split('|')),
    technologies: prepareTags(Discourse.SiteSettings.recipe_technologies_default.split('|')),
    tags: prepareTags(Discourse.SiteSettings.recipe_tags_default.split('|'))
  }
}

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
    var recipe = Recipe.create(defaultValues(this.categories));

    controller.setProperties({ categories: this.categories, model: recipe });
  },

  renderTemplate: function() {
    this.render('recipe-form');
  }
});
