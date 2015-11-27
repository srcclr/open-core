import PostMenuComponent from 'discourse/components/post-menu';
import { Button } from 'discourse/components/post-menu';
import ReplySettings from 'discourse/plugins/Discourse reports/discourse/mixins/reply-settings'

export default PostMenuComponent.extend(ReplySettings, {
  buttonForReply: function() {
    if (this.isReplyDisabledFor(this.get('controller.model.category.name'))) return;
    if (!this.get('controller.model.details.can_create_post')) return;

    var options = {className: 'create-comment'};

    var post = this.get('post');
    var reply_count = post.get('reply_count') || '';
    var icon = reply_count > 0 ? 'comment' : 'comment-o';
    options.innerHTML = '<span class="label">' + Discourse.Utilities.escapeExpression(reply_count) + '</span> <span class="add-icon">+</span>';

    return new Button('reply', 'post.controls.reply', icon, options);
  },

  _collapsedByDefault: function() {
    this.set('collapsed', false);
  }.on('init')
});
