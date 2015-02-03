import BreadCrumbs from 'discourse/components/bread-crumbs';

export default BreadCrumbs.reopen({
  parentCategories: Em.computed.filter('categories', function(category) {
    return _.contains(
      Discourse.SiteSettings.parent_categories.split('|'),
      category.get('name')
    );
  })
});
