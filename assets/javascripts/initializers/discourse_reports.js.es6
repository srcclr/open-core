var PREFIX = 'discourse/plugins/Discourse reports/discourse/';

export default {
  name: 'apply-discourse-reports',

  initialize: function(container) {
    require(PREFIX + 'routes/application').default;

    require(PREFIX + 'controllers/topic').default;
    require(PREFIX + 'controllers/topic').default;
    require(PREFIX + 'controllers/quote-button').default;

    require(PREFIX + 'models/topic').default;

    require(PREFIX + 'views/topic').default;
    require(PREFIX + 'views/post').default;
    require(PREFIX + 'views/login').default;
    require(PREFIX + 'views/signup').default;

    require(PREFIX + 'routes/login').default;
    require(PREFIX + 'routes/signup').default;
  }
};
