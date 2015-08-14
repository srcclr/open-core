var Section = Discourse.Model.extend({
  destroy() {
    return new Ember.RSVP.Promise((resolve) => {
      var topic_id = this.get('id'),
          topic_slug = this.get('slug');
      if (topic_id) {
        return Discourse.ajax("/t/" + topic_slug + "/" + topic_id, {
          type: 'PUT',
          data: { chapter_id: '', position: '0' }
        }).then(() => {
          resolve();
        });
      }
      resolve();
    });
  },
});

Section.reopenClass({
  makeSection(section) {
    return this.create({
      id: section.id,
      name: section.title,
      slug: section.slug,
      parent_topic_id: section.parent_topic_id
    });
  }
});

export default Section;
