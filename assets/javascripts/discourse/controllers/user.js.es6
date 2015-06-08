import User from 'discourse/controllers/user';

export default User.reopen({
  canSeeBlogs: Em.computed(function() {
    return this.get('model.can_see_blogs');
  }),

  canSeeHowtos: Em.computed(function() {
    return this.get('model.can_see_howtos');
  })
});
