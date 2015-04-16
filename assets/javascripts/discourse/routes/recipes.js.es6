import ShowFooter from 'discourse/mixins/show-footer';

function createTopic(topic) {
  var t = Discourse.Topic.create(topic);
  t.category = Discourse.Category.create(topic.category);
  return t;
};

export default Discourse.RecipesRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() { return this.redirectIfLoginRequired(); },

  beforeModel: function() {
    var self = this;

    return Discourse.ajax('/recipe_subcategories').then(function(result) {
      self.categoriesIds = _.pluck(result, 'id');
      self.categoriesIds.push(result[0].parent_category_id);
    });
  },

  model: function() {
     return PreloadStore.getAndRemove('recipes_topics', function() {
      return Discourse.ajax(Discourse.getURL("/recipes.json"));
    });
  },

  setupController: function(controller, model) {
    controller.setProperties({ categoriesIds: this.categoriesIds, model: model });
  },

  renderTemplate: function(data, topics) {
    this.render('recipes',
      {
        model: _.map(topics, createTopic),
        controller: 'recipes'
      }
    );
  }
});
