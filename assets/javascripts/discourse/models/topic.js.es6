function changeArchetype(model, archetype) {
  return Discourse.ajax(
    '/t/' + model.get('id') + '/archetype',
    { type: 'PUT', data: { id: archetype } }
  ).then(function () { model.set('archetype', archetype); });
}

export default Discourse.Topic.reopen({
  isSection: Em.computed.equal('archetype', 'section'),
  isPart: Em.computed.equal('archetype', 'part'),

  makeSection: function () {
    changeArchetype(this, 'section');
  },

  makePart: function() {
    changeArchetype(this, 'part');
  },

  makeDefaultArchetype: function () {
    var self = this;

    return Discourse.ajax(
      '/t/' + this.get('id') + '/archetype',
      { type: 'DELETE' }
    ).then(function () { self.set('archetype', 'regular'); });
  }
});
