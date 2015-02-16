export default Discourse.Chapter = Discourse.Model.extend({
  destroy: function() {
    var self = this;
    return new Ember.RSVP.Promise(function(resolve) {
      var id = self.get('id');
      if (id) {
        return Discourse.ajax("/admin/chapters/" + id, { type: 'DELETE' }).then(function() {
          resolve();
        });
      }
      resolve();
    });
  },

  save: function(attrs) {
    var id = this.get('id');
    if (!id) {
      return Discourse.ajax("/admin/chapters", {
        type: "POST",
        data: { part: attrs }
      });
    } else {
      return Discourse.ajax("/admin/chapters/" + id, {
        type: "PUT",
        data: { part: attrs }
      });
    }
  }
});
