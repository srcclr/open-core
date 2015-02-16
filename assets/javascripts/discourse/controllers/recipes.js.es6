export default Ember.Controller.extend({
  loading: false,
  actions: {
    toggleFilters: function() {
      $('.filter-toggler').toggleClass('opened');
      $('.recipe-filters').slideToggle(160);
    },
  }
});

Discourse.filterListToggler = Ember.View.extend({
  click: function(event) {
    event.preventDefault();
    var $parent;
    $(event.target).toggleClass('opened');
    $parent = $(event.target).closest('.filter-col');
    $parent.find('.filters').toggleClass('opened');
  }
});

Discourse.stepsToggler = Ember.View.extend({
  click: function(event) {
    event.preventDefault();
    var $parent = $(event.target).closest('li');
    $parent.find('.steps-content').slideToggle(160);
    $parent.find('a').toggleClass('fa-minus-circle');
  }
});
