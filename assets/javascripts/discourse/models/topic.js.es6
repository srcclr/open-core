function changeArchetype(model, archetype) {
  return Discourse.ajax(
    '/t/' + model.get('id') + '/archetype',
    { type: 'PUT', data: { id: archetype } }
  ).then(function () { model.set('archetype', archetype); });
}

export default Discourse.Topic.reopen({
  isToc: Em.computed.equal('archetype', 'toc'),
  isRecipe: Em.computed.equal('archetype', 'recipe'),
  isSection: Em.computed.equal('archetype', 'section'),

  makeToc: function() {
    changeArchetype(this, 'toc');
  },

  buildToc: function() {
    var self = this;

    return Discourse.ajax(
      '/table_contents/',
      { type: 'PUT' }
    ).then(function() { self.set('tocUpdated', Date.parse(new Date)); });
  },

  makeRecipe: function() {
    changeArchetype(this, 'recipe');
  },

  makeSection: function () {
    changeArchetype(this, 'section');
  },

  makeDefaultArchetype: function () {
    var self = this;

    return Discourse.ajax(
      '/t/' + this.get('id') + '/archetype',
      { type: 'DELETE' }
    ).then(function () { self.set('archetype', 'regular'); });
  }
});
