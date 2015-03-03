import QuoteButtonController from 'discourse/controllers/quote-button'

export default QuoteButtonController.reopen({
  selectText: function(postId) {
    this._super(postId);

    var self = this;

    Em.run.schedule('afterRender', function() {
      var quote_button_offset = $('.quote-button').offset(),
          top = quote_button_offset.top,
          left = quote_button_offset.left;

      if (_.isNull(self.get('target.model.chapter_id'))) {
        left = left + 120;
      }

      $('.reply-as-new-topic').offset({ top: top, left: left });
    });
  },
});
