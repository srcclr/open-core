export default Ember.Controller.extend({
  loading: false,
  linkToTableOfContent: Em.computed(function() {
    return Discourse.SiteSettings.link_to_table_of_content;
  })
});
