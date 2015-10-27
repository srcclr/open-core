import { propertyEqual } from "discourse/lib/computed";

export default Em.Controller.extend({
  loading: false,
  page: 0,

  firstPage: Em.computed.lte("page", 0),
  lastPage: propertyEqual("page", "model.totalPages"),

  loadMore() {
    return Discourse.ajax("/newsletters?page=" + this.get("page")).then((data) => {
      this.set("model", {
        newsletters: data.newsletters,
        latestNewsletter: data.latest_newsletter,
        totalPages: data.total_pages
      });
      this.set("loading", false);
    })
  },

  actions: {
    previousPage() {
      if (this.get("firstPage")) { return; }

      this.set("loading", true);
      this.set("page", this.get("page") - 1);

      return this.loadMore();
    },

    nextPage() {
      if (this.get("lastPage")) { return; }

      this.set("loading", true);
      this.set("page", this.get("page") + 1);

      return this.loadMore();
    }
  }
});
