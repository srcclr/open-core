var TOPICS = ['toc', 'how-to', 'section', 'blog'];

export default {
  get: function(topic, prefix) {
    var archetype = (topic || {}).archetype,
        template = prefix;

    if (TOPICS.indexOf(archetype) >= 0) {
      template += '-' + archetype;
    }

    return template;
  }
};
