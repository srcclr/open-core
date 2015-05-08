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
  this.resource('howtos', { path: '/c/how-tos' });
  this.resource('blogs', { path: '/c/blogs' });
  this.resource('taxonomy', { path: '/c/:parent_slug/taxonomy' });
  this.resource('taxonomy', { path: '/c/taxonomy' });
  this.resource('taxonomyFilter', { path: '/c/taxonomy/filter/:letter' });
  this.resource('categoryTopicId', { path: '/c/:category_slug/:slug' });

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
    this.route('how-tos');
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
