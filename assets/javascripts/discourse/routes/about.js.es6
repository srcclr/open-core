import AboutRoute from 'discourse/routes/about';

export default AboutRoute.reopen({
  model: function() {
    var about_page_url = Discourse.SiteSettings.about_page_url;
    if (about_page_url) {
      this.replaceWith(about_page_url.replace(/(https?\:)?\/\/[^\/]+/, ''));
    } else {
      return this._super();
    }
  }
})
