export default Discourse.View.extend({
  templateName: 'admin/templates/admin-reports',

  _disableCustomStylesheets: function() {
    if (this.session.get("disableCustomCSS")) {
      $("link.custom-css").attr("rel", "");
      this.session.set("disableCustomCSS", false);
    }
  }.on("willInsertElement"),

  _enableCustomStylesheets: function() {
    $("link.custom-css").attr("rel", "stylesheet");
  }.on("willDestroyElement")
});
