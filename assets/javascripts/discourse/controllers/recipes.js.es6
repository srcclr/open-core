export default Ember.Controller.extend({
  loading: false,
  actions: {
    toggleFilters: function(event) {
      $('.filter-toggler').toggleClass('opened');
      $('.recipe-filters').slideToggle(160);
    }
  }
});
