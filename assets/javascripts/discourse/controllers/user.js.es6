import User from 'discourse/controllers/user';

export default User.reopen({
  canSeeBlogs: Em.computed(function() {
    return !!Discourse.Category.findBySlug('blogs');
  }),

  canSeeHowtos: Em.computed(function() {
    return !!Discourse.Category.findBySlug('how-tos');
  })
});
