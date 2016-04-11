export default Ember.View.extend({
  tagName: 'input',
  classNameBindings:[':nav--search__input',':pv--',':ph-'],
  id: 'nav__catalog-search',
  attributeBindings:['placeholder'],
  placeholder: 'Search Catalog',

  focusIn: function(evt) {
    this.get('parentView').send('toggleBrowseButton',false);
  },

  focusOut: function(evt) {
    this.get('parentView').send('toggleBrowseButton',true);
  },

  keyPress: function(evt) {
    if (evt.keyCode == 13) {
      window.location.href = "https://srcclr.com/catalog/search#query=" + evt.currentTarget.value;
    }
  }
});
