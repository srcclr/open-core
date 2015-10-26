import AboutRoute from 'discourse/routes/about';

export default AboutRoute.reopen({
  beforeModel() {
    var about_page_url = Discourse.SiteSettings.about_page_url;
    if (about_page_url) {
      window.location.replace(about_page_url);
    }
  },

  model() {
    return Discourse.ajax("/about.json").then((result) => {
      return result;
    });
  },

  renderTemplate() {
    this.render('about-site')
  }
})
