function createTopic(topic) {
  const categories = Discourse.Category.list();
  var t = Discourse.Topic.create(topic);

  t.category = Discourse.Category.create(topic.category || categories.findBy("id", topic.category_id));

  return t;
};

export default Discourse.DiscoveryHomepageRoute = Discourse.Route.extend({
  model: function() {
    return Ember.RSVP.hash({
      active: $.getJSON(Discourse.getURL("/top")),
      recent: $.getJSON(Discourse.getURL("/homepage")),
      guides: $.getJSON(Discourse.getURL("/guides"))
    });
  },

  renderTemplate: function(data, model) {
    this.render("homepage", {
      model: {
        active: _(model.active.topic_list.topics).map(createTopic).take(5).value(),
        recent: _.map(model.recent, createTopic),
        guides: model.guides
      },

      controller: "homepage",
      into: "discovery",
      outlet: "homepage"
    });
  },

  activate: function() {
    Ember.$("html").addClass("homepage");
  },

  deactivate: function() {
    Ember.$("html").removeClass("homepage");
  }
});
