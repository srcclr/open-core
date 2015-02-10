var TOPICS = {toc: 'toc', recipe: 'recipe', section: 'section'};

export default {
  get: function(topic, prefix) {
    var archetype = (topic || {}).archetype,
        template = prefix;

    if (TOPICS.hasOwnProperty(archetype)) {
      template += '-' + TOPICS[archetype];
    }

    return template;
  }
};
