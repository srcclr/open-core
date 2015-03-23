import PostPartMenu from "discourse/plugins/Discourse reports/discourse/views/post-part-menu"

export default PostPartMenu.extend({
  clickEdit: function(post) {
    this.get('controller').transitionToRoute('recipesEdit', post.get('topic.id'));
  }
});
