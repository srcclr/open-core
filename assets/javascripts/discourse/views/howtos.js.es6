import LoadMore from "discourse/mixins/load-more";

export default Discourse.View.extend(LoadMore, {
  eyelineSelector: '.topic-list-item',

  actions: {
    loadMore: function() {
      var self = this;
      if (this.get("loading") ||
          this.get("model.allLoaded") ||
          Em.isPresent(this.get('controller.term'))) { return; }

      this.set("loading", true);

      this.get("controller").loadMore().then(function () {
        self.set("loading", false);
      });
    }
  }
});
