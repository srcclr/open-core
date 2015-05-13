import AboutRoute from 'discourse/routes/about';

export default AboutRoute.reopen({
  model: function() {
    return Discourse.ajax("/about.json").then(function(result) {
      return result;
    });
  },

  renderTemplate: function() {
    this.render('about-site')
  }
})
