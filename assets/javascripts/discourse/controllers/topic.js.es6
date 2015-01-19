import TopicController from 'discourse/controllers/topic';

export default TopicController.reopen({
  replyPosts: Ember.computed('postStream.posts', function() {
    return _.rest(this.get('postStream.posts'));
  }),

  postStreamChanged: Ember.observer('postStream.posts.@each', function() {
    var replies = _.rest(this.get('postStream.posts'));
    var existingPosts = this.get('replyPosts');

    existingPosts.pushObjects(_.difference(replies, this.get('replyPosts')));
    existingPosts.removeObjects(_.difference(existingPosts, replies));
  }),

  hasReplyPosts: Ember.computed('postStream.posts.@each', function() {
    return this.get('postStream.posts.length') > 1;
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
