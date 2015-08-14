import UrlSanitizer from 'discourse/plugins/Discourse reports/discourse/mixins/url-sanitizer';

export default Discourse.Controller.extend({
  loading: false,
  filterParams: {},
  availableLetters: [],

  loadMore() {
    var model = this.get("model");
    var params = _.extend({ offset: model.length }, this.get('filterParams'));

    if (model.get('allLoaded')) { return Ember.RSVP.resolve(); }

    return Discourse.ajax(
      UrlSanitizer.get('/taxonomies', params)
    ).then(function(data) {
      if (data.taxonomies.length === 0) {
        model.set("allLoaded", true);
      }
      model.addObjects(_.map(data.taxonomies, function(topic) {
        return Discourse.Topic.create(topic);
      }));
    });
  },

  taxonomyFilters: Em.computed('availableLetters', function() {
    var self = this;

    return _.times(26, function(index) {
      var letter = String.fromCharCode(index + 65);
      var disabled = self.get('availableLetters').indexOf(letter) < 0;

      return { letter: letter, disabled: disabled };
    })
  })
});
