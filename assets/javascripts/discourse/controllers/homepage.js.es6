export default Ember.Controller.extend({
  discussionsCategories: Ember.computed(function() {
    return Discourse.SiteSettings.parent_categories;
  }),

  linkToTableOfContent: Em.computed(function() {
    return Discourse.SiteSettings.link_to_table_of_content;
  })
});
