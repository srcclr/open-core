import createAdminUserPostsRoute from "discourse/routes/build-admin-user-posts-route";

export default createAdminUserPostsRoute("blogs").extend(Discourse.OpenComposer, {
  afterModel: function() {
    if (!Discourse.Category.findBySlug('blog')) {
      this.replaceWith('/404');
      return;
    }

    this._super.apply(this, arguments);
  },

  renderTemplate() {
    this.render("user/blogs", { into: "user" });
  },

  actions: {
    createTopic() {
      var composerController = this.controllerFor('composer');
      var category = Discourse.Category.findBySlug('blog') || {};

      composerController.open({
        action: 'createBlog',
        draftKey: 'createBlog',
        categoryId: category.id
      });
    }
  }
});
