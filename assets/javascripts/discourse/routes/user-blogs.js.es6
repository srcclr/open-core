import createAdminUserPostsRoute from "discourse/routes/build-admin-user-posts-route";

export default createAdminUserPostsRoute("blogs").extend(Discourse.OpenComposer, {
  renderTemplate() {
    this.render("user/blogs", { into: "user" });
  },

  saveIcon: function() {
  },

  saveText: function() {
  },

  actionTitle: function() {
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');
      composerController.open({
        action: 'createBlog',
        draftKey: 'createBlog'
      });
    }
  }
});
