export default Em.Controller.extend({
  canCreateBlog: Em.computed(function() {
    return !!Discourse.Category.findBySlug('blogs').get('permission');
  })
});
