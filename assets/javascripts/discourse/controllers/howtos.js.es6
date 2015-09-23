export default Em.Controller.extend({
  loading: false,
  shortTerm: false,

  searchPlaceholder: Em.computed(function() {
    return I18n.t('howtos.filter.search_placeholder');
  }),

  hideResults: Em.computed('loading', 'shortTerm', 'noResults', function() {
    return this.get('shortTerm') || this.get('noResults') || this.get('loading');
  }),

  searchAllHowtos: function() {
    var self = this;

    return Discourse.ajax('/howtos').then(function(results) {
      var content = _.map(results, function(topic) {
        return Discourse.Topic.create(topic);
      });
      self.setProperties({ noResults: false, content: content });
      self.set('loading', false);
    }).catch(function() {
      self.set('loading', false);
    });
  },

  loadMore() {
    var model = this.get("model");

    if (model.get('allLoaded')) { return Ember.RSVP.resolve(); }

    return Discourse.ajax('/howtos.json?offset=' + model.length).then(function(data){
      if (data.length === 0) {
        model.set("allLoaded", true);
      }
      model.addObjects(_.map(data, function(topic) {
        return Discourse.Topic.create(topic);
      }));
    });
  }
});
