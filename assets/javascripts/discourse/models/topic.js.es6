function changeArchetype(model, archetype) {
  return Discourse.ajax(
    '/t/' + model.get('id') + '/archetype',
    { type: 'PUT', data: { id: archetype } }
  ).then(function () { model.set('archetype', archetype); });
}

Discourse.Topic.reopenClass({
  idForSlugInCategory: function(slug, category) {
    return Discourse.ajax("/c/" + category + "/" + slug);
  }
});

export default Discourse.Topic.reopen({
  isToc: Em.computed.equal('archetype', 'toc'),
  isRecipe: Em.computed.equal('archetype', 'recipe'),
  isSection: Em.computed.equal('archetype', 'section'),
  isBlog: Em.computed.equal('archetype', 'blog'),

  makeToc: function() {
    changeArchetype(this, 'toc');
  },

  makeRecipe: function() {
    changeArchetype(this, 'recipe');
  },

  makeSection: function () {
    changeArchetype(this, 'section');
  },

  makeBlog: function () {
    changeArchetype(this, 'blog');
  },

  makeDefaultArchetype: function () {
    var self = this;

    return Discourse.ajax(
      '/t/' + this.get('id') + '/archetype',
      { type: 'DELETE' }
    ).then(function () { self.set('archetype', 'regular'); });
  }
});
