export default Ember.Component.extend({
  classNameBindings: ['containerClass', 'condition:visible'],

  containerClass: function() {
    return this.get('size') === 'small' ? 'inline-spinner' : undefined;
  }.property('size'),

  render: function(buffer) {
    if (this.get('condition')) {
      buffer.push(
        '<svg width="40" height="40" viewbox="0 0 40 40" class="mt block--center">'+
          '<polygon points="0 0 0 40 40 40 40 0" class="loading--rectangle" />'+
        '</svg>'
      );
    } else {
      return this._super(buffer);
    }
  },

  _conditionChanged: function() {
    this.rerender();
  }.observes('condition')
});
