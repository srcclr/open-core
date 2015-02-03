var TOPICS = {toc: 'toc', part: 'part', section: 'section'};

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
