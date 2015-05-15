import ShowFooter from 'discourse/mixins/show-footer';

export default Discourse.HowtosRoute = Discourse.Route.extend(ShowFooter, {
  beforeModel: function() { return this.redirectIfLoginRequired(); },

  model: function() {
     return PreloadStore.getAndRemove('howtos_topics', function() {
      return Discourse.ajax(Discourse.getURL("/howtos")).then(function(result) {
        return _.map(result, function(topic) {
          return Discourse.Topic.create(topic);
        })
      });
    });
  },

  setupController: function(controller, model) {
    controller.setProperties({ category: this.get('category'), model: model });
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');
      var category = Discourse.Category.findBySlug("how-tos") || {};

      composerController.open({
        action: "createTopicInCategory",
        draftKey: "createHowto",
        categoryId: category.id,
        metaData: { categorySlug: category.slug }
      });
    }
  }
});
