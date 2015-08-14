import Section from './section';

var Chapter = Discourse.Model.extend({
  destroy() {
    return new Ember.RSVP.Promise((resolve) => {
      var id = this.get('id'),
          discourse_reports_part_id = this.get('discourse_reports_part_id');
      if (id) {
        return Discourse.ajax("/admin/parts/" + discourse_reports_part_id + "/chapters/" + id, { type: 'DELETE' }).then(() => {
          resolve();
        });
      }
      resolve();
    });
  },

  save(attrs) {
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

Chapter.reopenClass({
  makeChapter(chapter, part_id) {
    return this.create({
      id: chapter.id,
      name: chapter.name,
      position: chapter.position,
      discourse_reports_part_id: part_id,
      sections: chapter.topics.map((section) => {
        return Section.makeSection(section);
      })
    });
  }
});

export default Chapter;
