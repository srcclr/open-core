import TopicController from 'discourse/controllers/topic';
import RecipeLanguagesTechnologies from 'discourse/plugins/Discourse reports/discourse/mixins/recipe-languages-technologies'

function getGrouped(items, tags) {
  return _.chain(items).filter(
      function(tag) { return _.contains(tags, tag.id);  }
    ).groupBy(
      function(element, index) { return Math.floor(index / 3) }
    ).toArray().value();
}

export default TopicController.reopen(RecipeLanguagesTechnologies, {
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

  hasLanguages: Em.computed.any('groupedLanguages'),
  hasTechnologies: Em.computed.any('groupedTechnologies'),

  groupedLanguages: Em.computed('model.tags', 'languages', function() {
    return getGrouped(this.get('languages'), this.get('model.tags'));
  }),

  groupedTechnologies: Em.computed('model.tags', 'technologies', function() {
    return getGrouped(this.get('technologies'), this.get('model.tags'));
  }),

  actions: {
    makeToc: function() {
      this.get('content').makeToc();
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

    makeBlog: function() {
      this.get('content').makeBlog();
    },

    makeDefaultArchetype: function() {
      this.get('content').makeDefaultArchetype();
    },
  }
});
