import QuoteButtonController from 'discourse/controllers/quote-button'

export default QuoteButtonController.reopen({
  needs: ['topic-quote-button'],

  selectText: function(postId) {
    this._super(postId);

    Em.run.schedule('afterRender', function() {
      var $quoteButton = $('.quote-button:first'),
          currentOffset = $quoteButton.offset();

      $('.reply-as-new-topic').offset({ top: currentOffset.top, left: currentOffset.left + 120 });
    });
  },
});
