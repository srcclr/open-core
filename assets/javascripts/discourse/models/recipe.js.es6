var CREATE_POST_ATTRIBUTES = ['title', 'archetype', 'raw', 'category', 'tags'];

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
  languages: [],
  technologies: [],

  save: function() {
    this.set('tags', this.get('languages').concat(this.get('techonologies')));

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
    var topicProps = this.getProperties(['title', 'category_id', 'tags']);
    var promise = Discourse.Topic.update(this.get('topic'), topicProps);
    var post = this.get('post');

    post.setProperties({ raw: this.get('raw') });

    return new Ember.RSVP.Promise(function(resolve, reject) {
      return promise.then(function() { return post.save(resolve, reject); }, reject);
    });
  },

  setLanguagesAndTechnologies: function(languages, technologies) {
    this.set('technologies', _.intersection(technologies, this.get('tags')));
    this.set('languages', _.intersection(languages, this.get('tags')));
  }
});

Recipe.edit = function(opts) {
  var recipe = new Recipe
  var topicProperties = ['title', 'category', 'id', 'url'];

  recipe.setProperties({
    topic: Discourse.Topic.create(Em.Object.create(opts).getProperties(topicProperties)),
    post: Discourse.Post.create(opts.post),
    tags: opts.tags || []
  });

  return recipe;
}

export default Recipe;
