export default Discourse.Section = Discourse.Model.extend({
  destroy: function() {
    var self = this;
    return new Ember.RSVP.Promise(function(resolve) {
      var topic_id = self.get('id'),
          topic_slug = self.get('slug');
      if (topic_id) {
        return Discourse.ajax("/t/" + topic_slug + "/" + topic_id, {
          type: 'PUT',
          data: { chapter_id: '', position: '0' }
        }).then(function() {
          resolve();
        });
      }
      resolve();
    });
  },
});

Discourse.Section.reopenClass({
  makeSection: function(section) {
    return Discourse.Section.create({
      id: section.id,
      name: section.title,
      slug: section.slug
    });
  }
});
