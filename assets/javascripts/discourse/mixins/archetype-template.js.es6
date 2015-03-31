var TOPICS = ['toc', 'recipe', 'section', 'blog'];

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
