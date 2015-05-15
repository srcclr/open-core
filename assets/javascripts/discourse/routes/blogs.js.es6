import ShowFooter from "discourse/mixins/show-footer";

export default Discourse.Route.extend(ShowFooter, {
  beforeModel: function() { return this.redirectIfLoginRequired(); },

  model: function() {
     return PreloadStore.getAndRemove('blog_topics', function() {
      return Discourse.ajax(Discourse.getURL("/blogs")).then(function(result) {
        return _.map(result, function(topic) {
          return Discourse.Topic.create(topic);
        })
      });
    });
  },

  afterModel: function() {
    this.set('category', Discourse.Category.findBySlug('blogs'));

    if (!this.get('category')) {
      this.replaceWith('/404');
      return;
    }
  },

  setupController: function(controller, model) {
    controller.set('model', model);
    controller.set('category', this.get('category'));

    this.controllerFor('blogs').set('canEditCategory', true);
    this.controllerFor('blogs').set('canCreateTopic', true);
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');

      composerController.open({
        action: 'createTopicInCategory',
        draftKey: 'createBlog',
        categoryId: this.get('category.id'),
        metaData: { categorySlug: this.get('category.slug') }
      });
    }
  }
});
