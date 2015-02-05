import BreadCrumbs from 'discourse/components/bread-crumbs';

export default BreadCrumbs.reopen({
  parentCategories: Em.computed.filter('categories', function(category) {
    return _.contains(
      Discourse.SiteSettings.parent_categories.split('|'),
      category.get('name')
    );
  }),

  categoryView: Em.View.extend({
    tagName: 'li',
    classNameBindings: ['active'],
    template: Ember.Handlebars.compile(
      "{{#link-to 'discovery.parentCategory' view.content.slug}}{{view.content.name}}{{/link-to}}"
    ),

    active: Em.computed('selectedCategory', function() {
      return this.selectedCategory && this.selectedCategory.slug === this.content.slug;
    })
  })
});
