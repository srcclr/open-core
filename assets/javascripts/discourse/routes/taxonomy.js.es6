import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

function wrapTopics(topics) {
  return _.map(topics, function(topic) { return Discourse.Topic.create(topic); })
}

export default Discourse.Route.extend({
  params: function() {},

  model: function(model, transition) {
    var self = this;
    self.filterParams = self.params(transition);

    return PreloadStore.getAndRemove('taxonomies_topics', function() {
      return Discourse.ajax(
        UrlSanitizer.get("/taxonomies", self.filterParams)
      ).then(function(result) { return result });
    });
  },

  afterModel: function() {
    var category = Discourse.Category.list().find(function(c) {
      return c.get('slug') === 'taxonomy';
    });

    this.set('category', category);

    if (!category) {
      this.replaceWith('/404');
      return;
    }
  },

  setupController: function(controller, model) {
    controller.set('model', wrapTopics(model.taxonomies));
    controller.set('category', this.get('category'));

    this.controllerFor('taxonomy').set('filterParams', this.filterParams);
    this.controllerFor('taxonomy').set('canEditCategory', true);
    this.controllerFor('taxonomy').set('availableLetters', model.available_letters || []);
    this.controllerFor('taxonomy').set('canCreateTopic', model.can_create_topic);
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
