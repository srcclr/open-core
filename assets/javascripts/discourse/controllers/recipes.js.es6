import searchForTerm from 'discourse/lib/search-for-term';

export default Ember.Controller.extend({
  loading: false,
  shortTerm: false,

  languages: Em.computed(function() {
    return Discourse.SiteSettings.languages.split('|');
  }),

  languagesProxy: Em.computed.map('languages', function(language) {
    return Ember.ObjectProxy.create({
      content: language,
      checked: false
    });
  }),

  languagesCheckedItems: Em.computed.filterBy('languagesProxy', 'checked', true),

  technologies: Em.computed(function() {
    return Discourse.SiteSettings.technologies.split('|');
  }),

  technologiesProxy: Em.computed.map('technologies', function(technology) {
    return Ember.ObjectProxy.create({
      content: technology,
      checked: false
    });
  }),

  technologiesCheckedItems: Em.computed.filterBy('technologiesProxy', 'checked', true),

  languagesAndTechnologiesCheckedItems: Em.computed.union('languagesCheckedItems', 'technologiesCheckedItems'),

  checkedItems: Ember.computed.mapBy('languagesAndTechnologiesCheckedItems', 'content'),

  searchPlaceholder: Em.computed(function() {
    return I18n.t('recipes.filter.search_placeholder');
  }),

  authors: Em.computed.mapBy('model', 'user.username'),

  publishers: Em.computed.uniq('authors'),

  hideResults: Em.computed('loading', 'shortTerm', 'noResults', function() {
    return this.get('loading') || this.get('shortTerm') || this.get('noResults');
  }),

  modelProxy: Em.computed.filter('model', function(topic) {
    var topicTagsAndUsername = _.union(topic.tags, topic.user.username),
        allFilters = _.union(this.get('checkedItems').join('|').toLowerCase().split('|'), this.get('publisher')),
        topicSatisfyFilters = _.intersection(allFilters, topicTagsAndUsername);

    return _.any(topicSatisfyFilters) || !_.any(allFilters);
  }),

  searchRecipes: function(term) {
    var self = this;

    searchForTerm(term, {
      typeFilter: 'topic'
    }).then(function(results) {
      var content = [];
      if (results) {
        content = _.filter(results.topics, function(topic) {
          return _.contains(self.get('categoriesIds'), topic.category_id);
        });
      }
      self.setProperties({ noResults: !_.any(content), content: content });
      self.set('loading', false);
    }).catch(function() {
      self.set('loading', false);
    });
  },

  searchAllRecipes: function() {
    var self = this;

    return Discourse.ajax('/recipes').then(function(results) {
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
      Ember.run.debounce(this, 'searchAllRecipes', 400);
    } else if (term.length >= Discourse.SiteSettings.min_search_term_length) {
      this.set('loading', true);
      Ember.run.debounce(this, 'searchRecipes', term, 400);
    } else {
      this.set('shortTerm', true);
    }
  }),

  resetForm: function() {
    $(".recipe-filter-form")[0].reset();
  },

  actions: {
    toggleFilters: function() {
      $('.filter-toggler').toggleClass('opened');
      $('.recipe-filters').slideToggle(160);
    },

    resetFilters: function() {
      var languagesProxy = this.get('languagesProxy'),
          technologiesProxy = this.get('technologiesProxy');

      _.invoke(languagesProxy, function() {
        this.set('checked', false);
      });
      _.invoke(technologiesProxy, function() {
        this.set('checked', false);
      });

      this.resetForm();
      this.newSearchNeeded();
    },

    applyFilters: function() {
      this.newSearchNeeded();
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
