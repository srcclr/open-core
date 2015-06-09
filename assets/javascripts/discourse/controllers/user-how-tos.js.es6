export default Discourse.Controller.extend({
  canCreateHowto: Em.computed(function() {
    return !!Discourse.Category.findBySlug('how-tos').get('permission');
  })
});
