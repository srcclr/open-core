var SUBMIT_PROPERTIES = [
  'loading',
  'canEditTitle',
  'canEditSection',
  'titleLength',
  'targetUsernames',
  'replyLength',
  'categoryId',
  'chapterId',
  'missingReplyCharacters'
];

var CLOSED = 'closed';
var OPEN = 'open';

var _edit_topic_serializer = {
  title: 'topic.title',
  categoryId: 'topic.category.id'
};

export default Discourse.Composer.reopen({
  canEditSection: Em.computed('topic.archetype', function() {
    return this.get('topic.archetype') === 'section';
  }),

  open: function(opts) {
    this._super.apply(this, arguments);
    this.setProperties({chapterId: this.get('topic.chapter_id')});
  },

  cantSubmitPost: Em.computed.apply(this, SUBMIT_PROPERTIES.concat(function() {
    this._super.apply(this, arguments);
    return this.get('canEditSection') && !this.get('chapterId');
  })),

  // When you edit a post
  // Cloned from original composer model in order
  // to override _edit_topic_serializer
  //
  editPost: function(opts) {
    var post = this.get('post'),
        oldCooked = post.get('cooked'),
        self = this,
        promise;

    // Update the title if we've changed it, otherwise consider it a
    // successful resolved promise
    if (this.get('title') &&
        post.get('post_number') === 1 &&
        this.get('topic.details.can_edit')) {

      var topicProps = this.getProperties(Object.keys(_edit_topic_serializer));

      // NOTE: Here is the difference between this one and original.
      topicProps['chapter_id'] = this.get('chapterId');

      promise = Discourse.Topic.update(this.get('topic'), topicProps);
    } else {
      promise = Ember.RSVP.resolve();
    }

    post.setProperties({
      raw: this.get('reply'),
      editReason: opts.editReason,
      imageSizes: opts.imageSizes,
      cooked: this.getCookedHtml()
    });
    this.set('composeState', CLOSED);

    return promise.then(function() {
      return post.save(function(result) {
        post.updateFromPost(result);
        self.clearState();
      }).catch(function(error) {
        var response = $.parseJSON(error.responseText);
        if (response && response.errors) {
          return(response.errors[0]);
        } else {
          return(I18n.t('generic_error'));
        }
        post.set('cooked', oldCooked);
        self.set('composeState', OPEN);
      });
    });
  }
})
