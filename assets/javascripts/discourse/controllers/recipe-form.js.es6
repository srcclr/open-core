export default Ember.Controller.extend({
  loading: false,

  languages: Em.computed(function() {
    return Discourse.SiteSettings.languages.split('|');
  }),

  technologies: Em.computed(function() {
    return Discourse.SiteSettings.technologies.split('|');
  }),

  actions: {
    submitRecipe: function() {
      var attrs = this.getProperties('title', 'category')
      attrs.archetype = 'recipe';

      if (_.isUndefined(attrs.category)) {
        var first_category = _.first(this.get('categories'));
        attrs.category = first_category.parent_category_id;
      }

      this.get('model').setProperties(attrs);

      this.get('model').save(function(opts) {
        return Discourse.URL.routeTo(opts.get('url'));

      }, function(error) {

        bootbox.alert(error.responseJSON.errors.join('.<br/>'));
      });
    }
  }
});
