var TOPICS = ['book', 'recipe'];

function templateFromArchetype(topic, prefix) {
  var archetype = (topic || {}).archetype;

  if (TOPICS.indexOf(archetype) >= 0) {
    return prefix + '-' + archetype;
  } else {
    return prefix;
  }
}

Discourse.PostView.reopen({
  templateName: function() {
    return templateFromArchetype(this.get('controller.content'), 'post');
  }.property().cacheable()
});
