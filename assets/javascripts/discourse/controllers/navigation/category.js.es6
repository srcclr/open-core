import NavigationCategoryController from 'discourse/controllers/navigation/category';

export default NavigationCategoryController.reopen({
  isHowtosCategory: Em.computed.equal('category.name', 'How-Tos'),

  categoryFromHowtos: Em.computed('category', function() {
    return this.get('isHowtosCategory');
  })
});
