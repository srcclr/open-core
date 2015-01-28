import QuoteButtonController from 'discourse/controllers/quote-button'

export default QuoteButtonController.reopen({
  needs: ['topic-quote-button'],

  quoteText: function() {
    this._super();
    this.get('controllers.topic-quote-button').set('buffer', '');
  },
});
