var CREATE_POST_ATTRIBUTES = ['title', 'archetype', 'raw', 'category'];

var Recipe = Discourse.Model.extend({
  init: function() {
    this.setProperties({
      post: Discourse.Post.create({ newPost: true }),
      topic: Discourse.Topic.create()
    });
  },

  title: Em.computed.alias('topic.title'),
  category: Em.computed.alias('topic.category'),
  category_id: Em.computed.alias('topic.category'),
  raw: Em.computed.alias('post.raw'),

  save: function() {
    return this.get('post.newPost') ? this.create() : this.update();
  },

  create: function() {
    var post = this.get('post');
    post.setProperties(this.getProperties(CREATE_POST_ATTRIBUTES));

    return new Ember.RSVP.Promise(function(resolve, reject) {
      return post.save(resolve, reject);
    });
  },

  update: function() {
    var topicProps = this.getProperties(['title', 'category_id']);
    var promise = Discourse.Topic.update(this.get('topic'), topicProps);
    var post = this.get('post');

    post.setProperties({ raw: this.get('raw') });

    return new Ember.RSVP.Promise(function(resolve, reject) {
      return promise.then(function() { return post.save(resolve, reject); }, reject);
    });
  },
});

Recipe.edit = function(opts) {
  var recipe = new Recipe
  var topicProperties = ['title', 'category', 'id', 'url'];

  recipe.setProperties({
    topic: Discourse.Topic.create(Em.Object.create(opts).getProperties(topicProperties)),
    post: Discourse.Post.create(opts.post)
  });

  return recipe;
}

export default Recipe;
