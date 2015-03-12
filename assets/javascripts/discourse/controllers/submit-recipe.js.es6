export default Ember.Controller.extend({
  loading: false,
  languages: Em.computed(function() {
    return Discourse.SiteSettings.languages.split('|');
  }),
  technologies: Em.computed(function() {
    return Discourse.SiteSettings.technologies.split('|');
  }),
  actions: {
    addStep: function() {
    }
  }
});
