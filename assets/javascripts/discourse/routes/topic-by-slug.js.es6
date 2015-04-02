import TopicBySlug from 'discourse/routes/topic-by-slug';

export default TopicBySlug.reopen({
  afterModel: function(result) {
    var path = result.url.replace(/(https?\:)?\/\/[^\/]+/, '');
    this.replaceWith(path);
  }
});
