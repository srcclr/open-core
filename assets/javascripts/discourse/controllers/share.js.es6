import ShareController from 'discourse/controllers/share';

export default ShareController.reopen({
  actions: {
    share: function(source) {
      var link = this.get('controllers.topic.url');

      if (_.isEmpty(this.get('link'))) {
        if (link.indexOf("/") === 0) {
          link = window.location.protocol + "//" + window.location.host + link;
        }
        this.set('link', link);
      }
      this._super.apply(this, arguments);
    }
  },
});
