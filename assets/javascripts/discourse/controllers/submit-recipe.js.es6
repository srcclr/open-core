export default Ember.Controller.extend({
  loading: false,
  recipeIsSubmitted: false,

  languages: Em.computed(function() {
    return Discourse.SiteSettings.languages.split('|');
  }),

  technologies: Em.computed(function() {
    return Discourse.SiteSettings.technologies.split('|');
  }),

  _generateRawContent: function() {
    return this.get('description') + "\n" + this.get('knowleage');
  },

  actions: {
    addStep: function() {
    },

    submitRecipe: function() {
      var attrs = this.getProperties('title', 'category'),
          self = this;

      attrs.raw = this._generateRawContent();
      attrs.archetype = 'recipe';

      if (_.isUndefined(attrs.category)) {
        var first_category = _.first(this.get('categories'));
        attrs.category = first_category.parent_category_id;
      }

      return Discourse.ajax('/posts', {
        type: 'POST',
        data: attrs
      }).then(function () {
        self.set('recipeIsSubmitted', true);
      });
    }
  }
});
