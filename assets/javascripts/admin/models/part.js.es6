import Chapter from './chapter';

var Part = Discourse.Model.extend({
  destroy() {
    return new Ember.RSVP.Promise((resolve) => {
      var id = this.get('id');
      if (id) {
        return Discourse.ajax("/admin/parts/" + id, { type: 'DELETE' }).then(() => {
          resolve();
        });
      }
      resolve();
    });
  },

  save(attrs) {
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

Part.reopenClass({
  makePart(part) {
    return this.create({
      id: part.id,
      position: part.position,
      name: part.name,
      description: part.description,
      chapters: part.chapters.map((chapter) => {
        return Chapter.makeChapter(chapter, part.id);
      })
    });
  },

  findAll() {
    return Discourse.ajax("/admin/parts").then((parts) => {
      return parts.map((part) => {
        return this.makePart(part);
      });
    });
  },
});

export default Part;
