import PostMenuView from 'discourse/views/post-menu';

export default PostMenuView.extend({
  _collapsedByDefault: function() {
    this.set('collapsed', false);
  }.on('init')
});
