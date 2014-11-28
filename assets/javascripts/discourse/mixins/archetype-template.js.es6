var TOPICS = ['book', 'recipe'];

export default {
  get: function(topic, prefix) {
    var archetype = (topic || {}).archetype;

    if (TOPICS.indexOf(archetype) >= 0) {
      return prefix + '-' + archetype;
    } else {
      return prefix;
    }
  }
};
