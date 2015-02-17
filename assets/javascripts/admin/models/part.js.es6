export default Discourse.Part = Discourse.Model.extend({
  destroy: function() {
    var self = this;
    return new Ember.RSVP.Promise(function(resolve) {
      var id = self.get('id');
      if (id) {
        return Discourse.ajax("/admin/parts/" + id, { type: 'DELETE' }).then(function() {
          resolve();
        });
      }
      resolve();
    });
  },

  save: function(attrs) {
    var id = this.get('id');
    if (!id) {
      return Discourse.ajax("/admin/parts", {
        type: "POST",
        data: { part: attrs }
      });
    } else {
      return Discourse.ajax("/admin/parts/" + id, {
        type: "PUT",
        data: { part: attrs }
      });
    }
  }
});

Discourse.Part.reopenClass({
  findAll: function() {
    return Discourse.ajax("/admin/parts").then(function(parts) {
      return parts.map(function(part) {
        return Discourse.Part.create({
          id: part.id,
          position: part.position,
          name: part.name,
          description: part.description,
          chapters: part.chapters.map(function(chapter) {
            return Discourse.Chapter.create({
              id: chapter.id,
              name: chapter.name,
              position: chapter.position
            });
          })
        });
      });
    });
  },
});
