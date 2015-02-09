export default Ember.Controller.extend({
  linkToTableOfContent: Em.computed(function() {
    return Discourse.SiteSettings.link_to_table_of_content;
  })
});
