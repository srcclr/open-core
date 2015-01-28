import QuoteButton from 'discourse/views/quote-button'

export default QuoteButton.extend({
  classNames: ['as-topic'],

  render: function(buffer) {
    buffer.push(I18n.t("post.reply_as_new_topic"));
  },
});
