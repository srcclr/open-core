import BufferedContent from 'discourse/mixins/buffered-content';

export default Discourse.AdminChapterController = Ember.ObjectController.extend(BufferedContent, {
  needs: ['adminToc'],
  editing: Ember.computed.empty('model.id'),

  chapterPosition: Em.computed(function() {
    return I18n.t('admin.toc.chapter.position');
  }),

  chapterName: function() {
    return I18n.t('admin.toc.chapter.name');
  }.property(),

  part: Em.computed(function() {
    return this.get('parentController.model');
  }),

  _performDestroy: function() {
    this.get('controllers.adminToc').send('destroy', this.get('model'), this.get('parentController.model.chapters'));
  },

  actions: {
    save: function() {
      var self = this;

      var attrs = this.get('buffered').getProperties('position', 'name');
      attrs.discourse_reports_part_id = this.get('part.id');

      this.get('model').save(attrs).then(function(res) {
        self.set('model.id', res.chapter.id);
        self.set('model.position', res.chapter.position);
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

    cancel: function() {
      var id = this.get('model.id');
      if (Ember.isEmpty(id)) {
        this._performDestroy();
      } else {
        this.rollbackBuffer();
        this.set('editing', false);
      }
    },

    edit: function() {
      this.set('editing', true);
    },

    destroy: function() {
      this._performDestroy();
    },
  }
});
