export default Discourse.Controller.extend({
  loading: false,

  loadMore() {
    var model = this.get("model");

    if (model.get('allLoaded')) { return Ember.RSVP.resolve(); }

    return Discourse.ajax('/taxonomies.json?offset=' + model.length).then(function(data){
      if (data.length === 0) {
        model.set("allLoaded", true);
      }
      model.addObjects(_.map(data, function(topic) {
        return Discourse.Topic.create(topic);
      }));
    });
  },
  taxonomyFilters: Em.computed(function() {
    return Array.apply(0, Array(26)).map(function(x,y) {
      return String.fromCharCode(y + 65);
    })
  })
});
