import TopicControler from 'discourse/controllers/topic';

export default TopicControler.reopen({
  replyPosts: Ember.computed(function() {
    return this.get('postStream.posts').slice(1);
  }),

  actions: {
    makeBook: function() {
      this.get('content').makeBook();
    },

    makeDefaultArchetype: function() {
      this.get('content').makeDefaultArchetype();
    },

    makePart: function() {
      this.get('content').makePart();
    }
  }
});
