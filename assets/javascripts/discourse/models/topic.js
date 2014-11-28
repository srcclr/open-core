function changeArchetype(model, archetype) {
  return Discourse.ajax(
    '/t/' + model.get('id') + '/archetype',
    { type: 'PUT', data: { id: archetype } }
  ).then(function () { model.set('archetype', archetype); });
}

Discourse.Topic = Discourse.Topic.reopen({
  isBook: Em.computed.equal('archetype', 'book'),
  isRecipe: Em.computed.equal('archetype', 'recipe'),

  makeBook: function () {
    changeArchetype(this, 'book');
  },

  makeRecipe: function() {
    changeArchetype(this, 'recipe');
  },

  makeDefaultArchetype: function () {
    var self = this;

    return Discourse.ajax(
      '/t/' + this.get('id') + '/archetype',
      { type: 'DELETE' }
    ).then(function () { self.set('archetype', 'regular'); })
  }
});
