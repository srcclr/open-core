function changeArchetype(model, archetype) {
  return Discourse.ajax(
    '/t/' + model.get('id') + '/archetype',
    { type: 'PUT', data: { id: archetype } }
  ).then(function () { model.set('archetype', archetype); });
}

export default Discourse.Topic.reopen({
  isToc: Em.computed.equal('archetype', 'toc'),
  isPart: Em.computed.equal('archetype', 'part'),
  isSection: Em.computed.equal('archetype', 'section'),

  makeToc: function() {
    changeArchetype(this, 'toc');
  },

  makePart: function() {
    changeArchetype(this, 'part');
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
