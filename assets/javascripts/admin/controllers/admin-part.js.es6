import Chapter from 'discourse/plugins/Discourse reports/admin/models/chapter';
import BufferedContent from 'discourse/mixins/buffered-content';

export default Discourse.AdminPartController = Ember.ObjectController.extend(BufferedContent, {
  needs: ['adminToc'],
  editing: Ember.computed.empty('id'),

  partPosition: function() {
    return I18n.t('admin.toc.part.position');
  }.property(),

  partName: function() {
    return I18n.t('admin.toc.part.name');
  }.property(),

  partDescription: function() {
    return I18n.t('admin.toc.part.description');
  }.property(),

  actions: {
    save: function() {
      var self = this;

      var attrs = this.get('buffered').getProperties('name', 'position', 'description');

      this.get('model').save(attrs).then(function(res) {
        self.set('model.id', res.part.id);
        self.set('model.position', res.part.position);
        self.set('model.description', res.part.description);
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
      this.get('controllers.adminToc').send('destroy', this.get('model'));
    },

    cancel: function() {
      var id = this.get('id');
      if (Ember.isEmpty(id)) {
        this.get('controllers.adminToc').send('destroy', this.get('model'));
      } else {
        this.rollbackBuffer();
        this.set('editing', false);
      }
    },

    createChapter: function() {
      var model = this.get('model');
      model.chapters.pushObject(Chapter.create());
    },
  }
});
