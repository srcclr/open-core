export default function() {
  this.resource('homepageReports', { path: '/homepage' });
  this.resource('supporters', { path: '/supporters' });
  this.resource('contributors', { path: '/contributors' });
  this.resource('communityRequest', { path: '/community_request' });
  this.resource('communities', { path: '/communities' }, function () {
    this.route('events', { paht: '/events' });
    this.route('groups', { paht: '/' });
    this.route('about');
  });
  this.resource('contact', { path: '/contact' });
  this.resource('about-site', { path: '/about-site' });
  this.resource('recipes', { path: '/recipes' });
  this.resource('recipesNew', { path: '/recipes/new' });
  this.resource('recipesEdit', { path: '/recipes/:id/edit' });
  this.resource('blogs', { path: '/c/blogs' });
  this.resource('taxonomy', { path: '/c/taxonomy' });

  this.resource('topicByFriendly', { path: '/:part-slug/:chapter-slug/:slug' });
  this.resource('table-of-contents');

  // User routes
  this.resource('user', { path: '/users/:username' }, function() {
    this.resource('userActivity', { path: '/activity' }, function() {
      var self = this;
      _.map(Discourse.UserAction.TYPES, function (id, userAction) {
        self.route(userAction, { path: userAction.replace('_', '-') });
      });
    });

    this.route('badges');
    this.route('recipes');
    this.route('blogs');

    this.route('flaggedPosts', { path: '/flagged-posts' });
    this.route('deletedPosts', { path: '/deleted-posts' });

    this.resource('userPrivateMessages', { path: '/private-messages' }, function() {
      this.route('mine');
      this.route('unread');
    });

    this.resource('preferences', function() {
      this.route('username');
      this.route('email');
      this.route('about', { path: '/about-me' });
      this.route('badgeTitle', { path: '/badge_title' });
      this.route('card-badge', { path: '/card-badge' });
    });

    this.route('invited');
  });
};
