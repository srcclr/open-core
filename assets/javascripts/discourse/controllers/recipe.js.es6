import RecipeController from 'discourse/controllers/topic';

export default RecipeController.reopen({
  initSelect2: function () {
    $('.select2').select2();
  }.on('init'),

  actions: {
    toggleFilters: function(event) {
      $('.filter-toggler').toggleClass('opened');
      $('.recipe-filters').slideToggle(160);
    }
  }
});
