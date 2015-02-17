import TopicController from 'discourse/controllers/topic';

export default TopicController.reopen({
  replyPosts: Ember.computed('postStream.posts', function() {
    return _.rest(this.get('postStream.posts'));
  }),

  replyAsNewTopicVisible: Em.computed.notEmpty('controllers.quote-button.buffer'),

  postStreamChanged: Ember.observer('postStream.posts.@each', function() {
    var replies = _.rest(this.get('postStream.posts'));
    var existingPosts = this.get('replyPosts');

    existingPosts.pushObjects(_.difference(replies, this.get('replyPosts')));
    existingPosts.removeObjects(_.difference(existingPosts, replies));
  }),

  hasReplyPosts: Ember.computed('postStream.posts.@each', function() {
    return this.get('postStream.posts.length') > 1;
  }),

  reloadATopic: Em.observer('content.tocUpdated', function() {
    if (this.get('content.tocUpdated')) {
      window.location.reload(true);
    }
  }),

  actions: {
    makeToc: function() {
      this.get('content').makeToc();
    },

    buildToc: function() {
      this.get('content').buildToc();
    },

    replyAsNewTopic: function () {
      this._super(this.get('controllers.quote-button.post'));
    },

    makeRecipe: function() {
      this.get('content').makeRecipe();
    },

    makeSection: function() {
      this.get('content').makeSection();
    },

    makeDefaultArchetype: function() {
      this.get('content').makeDefaultArchetype();
    },
  }
});
