import ShowFooter from "discourse/mixins/show-footer";

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
    var post = new Discourse.Post;
    post.set('newPost', true);

    controller.setProperties({ categories: this.categories, model: post });
  },

  renderTemplate: function() {
    this.render('recipe-form');
  }
});
