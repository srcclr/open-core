import searchForTerm from 'discourse/lib/search-for-term';

export default Ember.Controller.extend({
  loading: false,
  shortTerm: false,

  languages: Em.computed(function() {
    return Discourse.SiteSettings.languages.split('|');
  }),

  technologies: Em.computed(function() {
    return Discourse.SiteSettings.technologies.split('|');
  }),

  searchPlaceholder: Em.computed(function() {
    return I18n.t('recipes.filter.search_placeholder');
  }),

  hideResults: Em.computed('loading', 'shortTerm', 'noResults', function() {
    return this.get('loading') || this.get('shortTerm') || this.get('noResults');
  }),

  searchRecipes: function(term) {
    var self = this;

    term += ' category:Recipes';
    searchForTerm(term, {
      typeFilter: 'topic'
    }).then(function(results) {
      var content = [];
      if (results) {
        content = results.topics;
      }
      self.setProperties({ noResults: !results, content: content });
      self.set('loading', false);
    }).catch(function() {
      self.set('loading', false);
    });
  },

  searchAllRecipes: function() {
    var self = this;

    return Discourse.ajax('/c/recipes').then(function(results) {
      var content = _.map(results.topic_list.topics, function(topic) {
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
      Ember.run.debounce(this, 'searchAllRecipes', 400);
    } else if (term.length >= Discourse.SiteSettings.min_search_term_length) {
      this.set('loading', true);
      Ember.run.debounce(this, 'searchRecipes', term, 400);
    } else {
      this.set('shortTerm', true);
    }
  }),

  actions: {
    toggleFilters: function() {
      $('.filter-toggler').toggleClass('opened');
      $('.recipe-filters').slideToggle(160);
    }
  }
});

Discourse.filterListToggler = Ember.View.extend({
  click: function(event) {
    event.preventDefault();
    var $parent;
    $(event.target).toggleClass('opened');
    $parent = $(event.target).closest('.filter-col');
    $parent.find('.filters').toggleClass('opened');
  }
});

Discourse.stepsToggler = Ember.View.extend({
  click: function(event) {
    event.preventDefault();
    var $parent = $(event.target).closest('li');
    $parent.find('.steps-content').slideToggle(160);
    $parent.find('a').toggleClass('fa-minus-circle');
  }
});
