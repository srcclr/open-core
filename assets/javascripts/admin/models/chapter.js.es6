export default Discourse.Chapter = Discourse.Model.extend({
  destroy: function() {
    var self = this;
    return new Ember.RSVP.Promise(function(resolve) {
      var id = self.get('id'),
          discourse_reports_part_id = self.get('discourse_reports_part_id');
      if (id) {
        return Discourse.ajax("/admin/parts/" + discourse_reports_part_id + "/chapters/" + id, { type: 'DELETE' }).then(function() {
          resolve();
        });
      }
      resolve();
    });
  },

  save: function(attrs) {
    var id = this.get('id');
    if (!id) {
      return Discourse.ajax("/admin/parts/" + attrs.discourse_reports_part_id + "/chapters", {
        type: "POST",
        data: { chapter: attrs }
      });
    } else {
      return Discourse.ajax("/admin/parts/" + attrs.discourse_reports_part_id + "/chapters/" + id, {
        type: "PUT",
        data: { chapter: attrs }
      });
    }
  }
});

Discourse.Chapter.reopenClass({
  makeChapter: function(chapter, part_id) {
    return Discourse.Chapter.create({
      id: chapter.id,
      name: chapter.name,
      position: chapter.position,
      discourse_reports_part_id: part_id,
      sections: chapter.topics.map(function(section) {
        return Discourse.Section.makeSection(section);
      })
    });
  }
});
