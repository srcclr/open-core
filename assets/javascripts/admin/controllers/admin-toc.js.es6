import Part from 'discourse/plugins/Discourse reports/admin/models/part';

export default Discourse.AdminTocController = Ember.ArrayController.extend({
  tocRebuildSuccessful: false,

  _performDestroy: function(obj, model) {
    return obj.destroy().then(function() {
      model.removeObject(obj);
    });
  },

  actions: {
    createPart: function() {
      this.pushObject(Part.create({chapters: []}));
    },

    destroy: function(obj, parent) {
      var self = this;

      if (obj.get('id')) {
        bootbox.confirm(I18n.t("admin.toc.confirm_delete"), function(result) {
          if (result) { self._performDestroy(obj, parent); }
        });
      } else {
        self._performDestroy(obj, parent);
      }
    },

    rebuildToc: function() {
      var self = this;

      bootbox.confirm(I18n.t("admin.toc.rebuild_confirm"), function(result) {
        if (result) {
          Discourse.ajax('/table_contents', {
            type: 'PUT'
          }).then(function() {
            self.set('tocRebuildSuccessful', true);
          });
        }
      });
    },
  },
});
