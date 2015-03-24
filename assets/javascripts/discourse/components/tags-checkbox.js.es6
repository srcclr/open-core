export default Em.Component.extend({
  classNames: ['col-4'],
  tagName: 'label',

  init: function() {
    this._super();
    this.set('checked', _.contains(this.get('collection'), this.get('item')));
  },

  checkedObserver: Em.observer('checked', function() {
    var index = this.get('collection').indexOf(this.get('item'));

    if (index > 0) {
      this.get('collection').splice(index, 1)
    } else {
      this.get('collection').push(this.get('item'));
    }
  })
});
