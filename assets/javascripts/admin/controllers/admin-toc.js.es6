import Part from 'discourse/plugins/Discourse reports/admin/models/part';

export default Discourse.AdminTocController = Ember.ArrayController.extend({
  _performDestroy: function(part, model) {
    return part.destroy().then(function() {
      model.removeObject(part);
    });
  },

  actions: {
    createPart: function() {
      this.pushObject(Part.create());
    },

    destroy: function(part) {
      var model = this.get('model'),
          self = this;

      if (part.get('id')) {
        bootbox.confirm(I18n.t("admin.toc.part.confirm_delete"), function(result) {
          if (result) { self._performDestroy(part, model); }
        });
      } else {
        self._performDestroy(part, model);
      }
    }
  },
});
