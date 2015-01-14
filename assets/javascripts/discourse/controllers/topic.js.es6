import TopicController from 'discourse/controllers/topic';

export default TopicController.reopen({
  replyPosts: Ember.computed('postStream.posts', function() {
    return this.get('postStream.posts').slice(1);
  }),

  hasReplyPosts: Ember.computed('replyPosts', function() {
    return this.get('replyPosts').length > 0;
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
