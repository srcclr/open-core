export default Discourse.TableOfContentsRoute = Discourse.Route.extend({
  redirect: function() {
    this.transitionTo(Discourse.SiteSettings.link_to_table_of_content);
  }
});
