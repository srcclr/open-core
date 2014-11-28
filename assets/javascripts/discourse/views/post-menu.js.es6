import PostMenuView from 'discourse/views/post-menu';
import { Button } from 'discourse/views/post-menu';

export default PostMenuView.reopen({
  buttonForReply: function() {
    if (!this.get('controller.model.details.can_create_post')) return;
    var options = {className: 'create-comment'};

    var post = this.get('post');
    var reply_count = post.get('reply_count') || '+';
    options.innerHTML = '<span class="label">' + reply_count + "</span>"

    return new Button('reply', 'post.controls.reply', 'comment', options);
  }
});
