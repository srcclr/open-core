import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.Controller.extend({
  loading: false,
  filterParams: {},

  loadMore() {
    var model = this.get("model");
    var params = _.extend({ offset: model.length }, this.get('filterParams'));

    if (model.get('allLoaded')) { return Ember.RSVP.resolve(); }

    return Discourse.ajax(
      UrlSanitizer.get('/taxonomies', params)
    ).then(function(data) {
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
