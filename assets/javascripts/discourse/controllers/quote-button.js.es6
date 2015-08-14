import QuoteButtonController from 'discourse/controllers/quote-button'
import ReplySettings from 'discourse/plugins/Discourse reports/discourse/mixins/reply-settings'

export default QuoteButtonController.reopen(ReplySettings, {
  selectText: function(postId) {
    this._super(postId);

    if (this.get('target.model.archetype') === 'regular') return;

    var isReplyDisabled = this.isReplyDisabledFor(this.get('target.model.category.name'));

    Em.run.schedule('afterRender', function() {
      var quote_button_offset = $('.quote-button').offset(),
          top = quote_button_offset.top,
          left = quote_button_offset.left;

      if (isReplyDisabled) {
        $('.quote-button').addClass('collapsed-quote-button');
      } else {
        left = left + 120;
      }

      $('.reply-as-new-topic').offset({ top: top, left: left });
    });
  },
});
