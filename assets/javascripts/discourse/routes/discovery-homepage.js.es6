function createTopic(topic) {
  const categories = Discourse.Category.list();
  var t = Discourse.Topic.create(topic);

  t.category = Discourse.Category.create(topic.category || categories.findBy("id", topic.category_id));

  return t;
};

export default Discourse.DiscoveryHomepageRoute = Discourse.Route.extend({
  model: function() {
    return Discourse.ajax("/newsletters").then((data) => {
      return {
        newsletters: data.newsletters,
        totalPages: data.total_pages
      }
    });
  },

  renderTemplate: function(data, model) {
    this.render("newsletters", {
      model: model,
      into: "discovery",
      outlet: "homepage"
    });
  },

  activate: function() {
    Ember.$("html").addClass("newsletter");
  },

  deactivate: function() {
    Ember.$("html").removeClass("newsletter");
  }
});
