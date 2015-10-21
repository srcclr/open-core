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
  this.resource('blogs', { path: '/c/blogs' });
  this.resource('taxonomy', { path: '/c/:parent_slug/taxonomy' });
  this.resource('taxonomy', { path: '/c/taxonomy' });
  this.resource('taxonomyFilter', { path: '/c/taxonomy/filter/:letter' });
  this.resource('categoryTopicId', { path: '/c/:category_slug/:slug' });

  this.resource('topicByFriendly', { path: '/:part-slug/:chapter-slug/:slug' });
  this.resource('guides');
  this.resource('guide', { path: '/guides/:slug' });
  this.resource('projects');
  this.resource('project', { path: '/projects/:id' });
  this.resource('security-headers', { path: '/security-headers' });
  this.resource('newsletter', { path: '/nwslttr' });
};
