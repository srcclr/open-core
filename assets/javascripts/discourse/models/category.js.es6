var _uncategorized;

export default Discourse.Category.reopenClass({
  findUncategorized: function() {
    _uncategorized = _uncategorized || Discourse.Category.list().findBy('slug', Discourse.Site.currentProp('uncategorized_category_slug'));

    return _uncategorized;
  }
});
