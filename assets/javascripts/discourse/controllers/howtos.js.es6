import searchForTerm from 'discourse/lib/search-for-term';

export default Ember.Controller.extend({
  loading: false,
  shortTerm: false,

  searchPlaceholder: Em.computed(function() {
    return I18n.t('howtos.filter.search_placeholder');
  }),

  hideResults: Em.computed('loading', 'shortTerm', 'noResults', function() {
    return this.get('shortTerm') || this.get('noResults') || this.get('loading');
  }),

  searchHowtos: function(term) {
    var self = this;

    searchForTerm('category:How-Tos ' + term, {
      typeFilter: 'topic'
    }).then(function(results) {
      if (results) {
        self.set('content', results.topics);
      }
      self.set('noResults', !results);
      self.set('loading', false);
    }).catch(function() {
      self.set('loading', false);
    });
  },

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

  newSearchNeeded: Em.observer('term', function() {
    this.setProperties({ noResults: false, shortTerm: false });
    var term = (this.get('term') || '').trim();
    if (term.length === 0) {
      this.set('loading', true);
      Ember.run.debounce(this, 'searchAllHowtos', 400);
    } else if (term.length >= Discourse.SiteSettings.min_search_term_length) {
      this.set('loading', true);
      Ember.run.debounce(this, 'searchHowtos', term, 400);
    } else {
      this.set('shortTerm', true);
    }
  }),

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
