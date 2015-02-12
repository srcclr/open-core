function createTopic(topic) {
  var t = Discourse.Topic.create(topic);
  t.category = Discourse.Category.create(topic.category);

  return t;
};

export default Discourse.RecipesRoute = Discourse.Route.extend({
  model: function() {
     return PreloadStore.getAndRemove('recipes_topics', function() {
      return Discourse.ajax(Discourse.getURL("recipes.json"));
    });
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
