export default Ember.Controller.extend({
  discussionsCategories: Ember.computed(function() {
    return ['Process', 'Design/Architecture', 'Coding', 'Testing/QA', 'Monitoring'];
  }),

  linkToTableOfContent: Em.computed(function() {
    return Discourse.SiteSettings.link_to_table_of_content;
  })
});
