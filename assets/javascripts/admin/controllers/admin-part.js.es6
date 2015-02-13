import Part from 'discourse/plugins/Discourse reports/admin/models/part';
import BufferedContent from 'discourse/mixins/buffered-content';

export default Discourse.AdminPartController = Ember.ObjectController.extend(BufferedContent, {
  needs: ['admin-toc'],
  editing: Ember.computed.empty('id'),

  actions: {
    save: function() {
      var self = this;

      var attrs = this.get('buffered').getProperties('name', 'position');

      this.get('model').save(attrs).then(function(res) {
        self.set('model.id', res.part.id);
        self.set('model.position', res.part.position);
        self.set('editing', false);
        self.commitBuffer();
      }).catch(function(e) {
        var msg = I18n.t("generic_error");
        if (e.responseJSON && e.responseJSON.errors) {
          msg = I18n.t("generic_error_with_reason", {error: e.responseJSON.errors.join('. ')});
        }
        bootbox.alert(msg);
      });
    },

    edit: function() {
      this.set('editing', true);
    },

    destroy: function() {
      this.get('controllers.admin-toc').send('destroy', this.get('model'));
    },

    cancel: function() {
      var id = this.get('id');
      if (Ember.isEmpty(id)) {
        this.get('controllers.admin-toc').send('destroy', this.get('model'));
      } else {
        this.rollbackBuffer();
        this.set('editing', false);
      }
    }
  }
});
