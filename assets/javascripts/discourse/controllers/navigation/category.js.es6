import NavigationCategoryController from 'discourse/controllers/navigation/category';

export default NavigationCategoryController.reopen({
  isRecipesCategory: Em.computed.equal('category.name', 'Recipes'),
  isRecipesSubcategory: Em.computed.equal('category.parentCategory.name', 'Recipes'),

  categoryFromRecipes: Em.computed('category', function() {
    return this.get('isRecipesCategory') || this.get('isRecipesSubcategory');
  })
});
