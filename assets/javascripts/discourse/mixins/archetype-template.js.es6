var TOPICS = ['toc', 'part', 'section'];

export default {
  get: function(topic, prefix) {
    var archetype = (topic || {}).archetype,
        template = prefix;

    if (archetype === 'toc') {
      template += '-part';
    } else if (TOPICS.indexOf(archetype) >= 0) {
      template += '-' + archetype;
    }

    return template;
  }
};
