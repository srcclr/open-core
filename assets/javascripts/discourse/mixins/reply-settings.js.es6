export default Em.Mixin.create({
  disabledCategoriesList: function() {
    return Discourse.SiteSettings.disable_reply_categories.split('|');
  },

  replyDisabled: function() {
    return Discourse.SiteSettings.disable_reply;
  },

  isReplyDisabledFor: function(category) {
    return this.replyDisabled() && _.contains(this.disabledCategoriesList(), category);
  },
});
