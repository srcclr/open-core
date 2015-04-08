import User from 'discourse/controllers/user';

export default User.reopen({
  canSeeBlogs: Em.computed(function() {
    return !!Discourse.Category.findBySlug('blog');
  }),

  canSeeRecipes: Em.computed(function() {
    return !!Discourse.Category.findBySlug('recipe');
  })
});
