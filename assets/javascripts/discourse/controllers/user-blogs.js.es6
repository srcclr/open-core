export default Discourse.Controller.extend({
  canCreateBlog: Em.computed(function() {
    return !!Discourse.Category.findBySlug('blogs').get('permission');
  })
});
