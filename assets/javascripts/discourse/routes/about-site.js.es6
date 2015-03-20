import ShowFooter from "discourse/mixins/show-footer";
export default Discourse.AboutSiteRoute = Discourse.Route.extend(ShowFooter, {
  redirect: function() {
    var app = this.controllerFor('application');

    if (app.get('loginRequired') || !Discourse.SiteSettings.enable_about_page) {
      this.replaceWith('login');
    }
  }
});
