import AboutRoute from 'discourse/routes/about';

export default AboutRoute.reopen({
  redirect: function() {
    var about_page_url = Discourse.SiteSettings.about_page_url;
    if (about_page_url) {
      this.transitionTo(about_page_url);
    }
  }
})
