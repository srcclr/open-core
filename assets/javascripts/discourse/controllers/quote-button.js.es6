import QuoteButtonController from 'discourse/controllers/quote-button'

export default QuoteButtonController.reopen({
  selectText: function(postId) {
    this._super(postId);

    Em.run.schedule('afterRender', function() {
      var currentOffset = $('.quote-button').offset();

      $('.reply-as-new-topic').offset({
        top: currentOffset.top,
        left: currentOffset.left + 120
      });
    });
  },
});
