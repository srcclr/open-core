export default Discourse.AdminSectionController = Ember.ObjectController.extend({
  needs: ['adminToc'],

  actions: {
    destroy: function() {
      this.get('controllers.adminToc').send('destroy', this.get('model'), this.get('parentController.model.sections'));
    },
  }
});
