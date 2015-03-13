(function() {
  var ADMIN_PREFIX = 'discourse/plugins/Discourse reports/admin/';

  require(ADMIN_PREFIX + 'controllers/admin-toc').default;
  require(ADMIN_PREFIX + 'controllers/admin-part').default;
  require(ADMIN_PREFIX + 'controllers/admin-chapter').default;

  require(ADMIN_PREFIX + 'models/part').default;
  require(ADMIN_PREFIX + 'models/chapter').default;
  require(ADMIN_PREFIX + 'models/section').default;

  require(ADMIN_PREFIX + 'routes/admin-toc').default;

  require(ADMIN_PREFIX + 'views/admin').default;
  require(ADMIN_PREFIX + 'views/admin-toc').default;
  require(ADMIN_PREFIX + 'views/admin-part').default;
  require(ADMIN_PREFIX + 'views/admin-chapter').default;
})();
