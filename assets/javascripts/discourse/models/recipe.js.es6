var CREATE_POST_ATTRIBUTES = ['title', 'archetype', 'raw', 'category', 'tags'];

var Recipe = Discourse.Model.extend({
  init: function() {
    var topic = this.get('topic') || {};
    var post = _.extend(this.get('post') || {}, { newPost: true });

    this.setProperties({
      post: Discourse.Post.create(post),
      topic: Discourse.Topic.create(topic)
    });
  },

  title: Em.computed.alias('topic.title'),
  category: Em.computed.alias('topic.category'),
  category_id: Em.computed.alias('topic.category'),
  raw: Em.computed.alias('post.raw'),
  languages: [],
  technologies: [],
  tags: [],

  save: function() {
    var tags = this.get('tags');
    var languages = this.get('languages');
    var technologies = this.get('technologies');

    this.set('tags', tags.concat(languages).concat(technologies));

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
    languages = _.map(languages, function(item) { return item.id });
    technologies = _.map(technologies, function(item) { return item.id });

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
