import createAdminUserPostsRoute from "discourse/routes/build-admin-user-posts-route";

export default function (item) {
  return createAdminUserPostsRoute(item + "s").extend(Discourse.OpenComposer, {
    afterModel: function() {
      if (!Discourse.Category.findBySlug(item + "s")) {
        this.replaceWith('/404');
        return;
      }

      this._super.apply(this, arguments);
    },

    renderTemplate() {
      this.render("user/" + item + "s", { into: "user" });
    },

    actions: {
      createTopic() {
        var composerController = this.controllerFor('composer');
        var category = Discourse.Category.findBySlug(item + "s") || {};

        composerController.open({
          action: "createTopicInCategory",
          draftKey: "create" + item.capitalize(),
          categoryId: category.id,
          metaData: { categorySlug: category.slug }
        });
      }
    }
  });
}
