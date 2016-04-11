export default Ember.Component.extend({

  showBrowse: true,
  target: Em.computed.alias("targetObject"),

  actions: {
    toggleBrowseButton(bool) {
      let _self = this;
      if (bool) {
        Ember.run.later((function() {
            _self.set('showBrowse',bool);
          }), 200);
      } else {
        this.set('showBrowse',bool);
      }
    },

    browseCatalog() {
      window.location.href = "https://srcclr.com/catalog/search#_";
    }
  }
});
