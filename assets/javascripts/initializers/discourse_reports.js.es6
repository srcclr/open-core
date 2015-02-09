var PREFIX = 'discourse/plugins/Discourse reports/discourse/';

export default {
  name: 'apply-discourse-reports',

  initialize: function(container) {
    require(PREFIX + 'components/bread-crumbs').default;

    require(PREFIX + 'controllers/user/index').default;
    require(PREFIX + 'controllers/homepage').default;
    require(PREFIX + 'controllers/quote-button').default;
    require(PREFIX + 'controllers/topic').default;

    require(PREFIX + 'models/topic').default;

    require(PREFIX + 'routes/application').default;
    require(PREFIX + 'routes/discovery-homepage').default;
    require(PREFIX + 'routes/discovery').default;
    require(PREFIX + 'routes/login').default;
    require(PREFIX + 'routes/signup').default;
    require(PREFIX + 'routes/user-index').default;

    require(PREFIX + 'views/login').default;
    require(PREFIX + 'views/post').default;
    require(PREFIX + 'views/signup').default;
    require(PREFIX + 'views/topic').default;
    require(PREFIX + 'views/terms-of-use').default;
    require(PREFIX + 'views/supporters').default;
    require(PREFIX + 'views/contributors').default;
    require(PREFIX + 'views/privacy-policy').default;
    require(PREFIX + 'views/communities').default;
  }
};
