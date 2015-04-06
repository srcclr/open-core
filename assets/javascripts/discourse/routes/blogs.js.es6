import ShowFooter from "discourse/mixins/show-footer";

export default Discourse.Route.extend(ShowFooter, {
  model: function() {
     return PreloadStore.getAndRemove('blog_topics', function() {
      return Discourse.ajax(Discourse.getURL("/blogs")).then(function(result) {
        return _.map(result, function(topic) {
          return Discourse.Topic.create(topic);
        })
      });
    });
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');
      var category = Discourse.Category.findBySlug('blog') || {};

      composerController.open({
        action: 'createBlog',
        draftKey: 'createBlog',
        categoryId: category.id
      });
    }
  }
});
