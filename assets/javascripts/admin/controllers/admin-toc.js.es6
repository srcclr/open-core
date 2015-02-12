export default Ember.ObjectController.extend({
  createPartDisabled: Em.computed.empty('partName'),

  actions: {
    createPart: function() {
      var self = this;
      Discourse.ajax("/admin/part", {
        type: 'POST',
        data: { name: this.get('partName'), position: this.get('partPosition') }
      }).then(function (part) {
        self.get('model').pushObject(part);
      });
    },

    editPart: function(part) {
      // bootbox.confirm(I18n.t("admin.api.confirm_regen"), I18n.t("no_value"), I18n.t("yes_value"), function(result) {
      //   if (result) {
      //     part.regenerate();
      //   }
      // });
    },

    deletePart: function(part) {
      var self = this;
      bootbox.confirm(I18n.t("admin.toc.part.confirm_delete"), I18n.t("no_value"), I18n.t("yes_value"), function(result) {
        if (result) {
          part.delete().then(function() {
            self.get('model').removeObject(part);
          });
        }
      });
    }
  },
});
