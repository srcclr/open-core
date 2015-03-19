export default Ember.Controller.extend({
  loading: false,

  enableAboutPage: Em.computed(function() {
    return Discourse.SiteSettings.enable_about_page;
  })
});
