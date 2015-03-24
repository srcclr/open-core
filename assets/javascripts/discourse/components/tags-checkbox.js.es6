export default Em.Component.extend({
  classNames: ['col-4'],
  tagName: 'label',

  init: function() {
    this._super();
    this.set('checked', _.contains(this.get('collection'), this.get('item.id')));
  },

  checkedObserver: Em.observer('checked', function() {
    var index = this.get('collection').indexOf(this.get('item.id'));

    if (index > 0) {
      this.get('collection').splice(index, 1)
    } else {
      this.get('collection').push(this.get('item.id'));
    }
  })
});
