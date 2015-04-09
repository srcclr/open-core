import ShowFooter from "discourse/mixins/show-footer";

export default Discourse.Route.extend(ShowFooter, {
  model: function() {
     return PreloadStore.getAndRemove('taxonomy_topics', function() {
      return Discourse.ajax(Discourse.getURL("/taxonomies")).then(function(result) {
        return _.map(result, function(topic) {
          return Discourse.Topic.create(topic);
        })
      });
    });
  },

  afterModel: function() {
    this.set('category', Discourse.Category.findBySlug('taxonomy'));

    if (!this.get('category')) {
      this.replaceWith('/404');
      return;
    }
  },

  setupController: function(controller, model) {
    controller.set('model', model);
    controller.set('category', this.get('category'));

    this.controllerFor('taxonomy').set('canEditCategory', true);
    this.controllerFor('taxonomy').set('canCreateTopic', true);
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');

      composerController.open({
        action: 'createTopicInCategory',
        draftKey: 'createTopicInTaxonomy',
        categoryId: this.get('category.id'),
        metaData: { categorySlug: this.get('category.slug') }
      });
    }
  }
});
