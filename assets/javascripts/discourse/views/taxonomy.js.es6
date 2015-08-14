import LoadMore from "discourse/mixins/load-more";

export default Discourse.View.extend(LoadMore, {
  eyelineSelector: '.topic-list-item',

  actions: {
    loadMore: function() {
      var self = this;
      if (this.get("controller.loading") || this.get("model.allLoaded")) { return; }

      this.set("controller.loading", true);

      this.get("controller").loadMore().then(function () {
        self.set("controller.loading", false);
      });
    }
  }
});
