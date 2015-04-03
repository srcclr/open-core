export default {
  name: 'add-fields-to-composer',

  initialize: function(container) {
    Discourse.Composer.serializeToTopic('position', 'topic.position');
    Discourse.Composer.serializeToTopic('chapter_id', 'topic.chapter_id');
    Discourse.Composer.serializeOnCreate('archetype', 'archetype');
  }
};
