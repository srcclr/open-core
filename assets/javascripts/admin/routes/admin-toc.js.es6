import Part from 'discourse/plugins/Discourse reports/admin/models/part';

export default Discourse.AdminTocRoute = Discourse.Route.extend({
  model: function() {
    return Part.findAll();
  },

  actions: {
    willTransition: function(transition) {
      this.controller.set('tocRebuildSuccessful', false);
      return true;
    }
  }
});
