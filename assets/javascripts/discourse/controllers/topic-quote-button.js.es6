import QuoteButtonController from 'discourse/controllers/quote-button'

export default QuoteButtonController.extend({
  needs: ['quote-button'],

  selectText: function(postId) {
    this._super(postId);
    Em.run.schedule('afterRender', function() {
      var $quoteButton = $('.quote-button:first'),
          currentOffset = $quoteButton.offset();

      $('.as-topic').offset({ top: currentOffset.top, left: currentOffset.left + 120 });
    });
  },

  quoteText: function() {
    var post = this.get('post'),
        composerController = this.get('controllers.composer'),
        quotedText = Discourse.Quote.build(post, this.get('buffer')),
        self = this;

    composerController.open({
      action: Discourse.Composer.CREATE_TOPIC,
      draftKey: Discourse.Composer.REPLY_AS_NEW_TOPIC_KEY
    }).then(function() {
      return Em.isEmpty(quotedText) ? Discourse.Post.loadQuote(post.get('id')) : quotedText;
    }).then(function(q) {
      var postUrl = "" + location.protocol + "//" + location.host + (post.get('url')),
          postLink = "[" + post.get('topic.title') + "](" + postUrl + ")";
      composerController.appendText(I18n.t("post.continue_discussion", { postLink: postLink }) + "\n\n" + q);
    });

    this.set('buffer', '');
    this.get('controllers.quote-button').set('buffer', '');
  },
});
