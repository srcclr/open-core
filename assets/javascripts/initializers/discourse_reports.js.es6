var PREFIX = 'discourse/plugins/Discourse reports/discourse/';

export default {
  name: 'apply-discourse-reports',

  initialize: function(container) {
    window.DiscourseReports = {};

    require(PREFIX + 'components/bread-crumbs').default;
    require(PREFIX + 'components/google-maps').default;
    require(PREFIX + 'components/maps-filters').default;
    require(PREFIX + 'components/event-datepicker').default;
    require(PREFIX + 'components/post-section-menu').default;

    require(PREFIX + 'controllers/application').default;
    require(PREFIX + 'controllers/user-index').default;
    require(PREFIX + 'controllers/preferences').default;
    require(PREFIX + 'controllers/user').default;
    require(PREFIX + 'controllers/composer').default;
    require(PREFIX + 'controllers/homepage').default;
    require(PREFIX + 'controllers/communities').default;
    require(PREFIX + 'controllers/communities-events').default;
    require(PREFIX + 'controllers/communities-groups').default;
    require(PREFIX + 'controllers/quote-button').default;
    require(PREFIX + 'controllers/topic').default;
    require(PREFIX + 'controllers/howto').default;
    require(PREFIX + 'controllers/community-request').default;
    require(PREFIX + 'controllers/login').default;
    require(PREFIX + 'controllers/login-help').default;
    require(PREFIX + 'controllers/navigation/category').default;
    require(PREFIX + 'controllers/blogs').default;
    require(PREFIX + 'controllers/share').default;
    require(PREFIX + 'controllers/discovery').default;

    require(PREFIX + 'models/composer').default;
    require(PREFIX + 'models/topic').default;
    require(PREFIX + 'models/category').default;
    DiscourseReports.Map = require(PREFIX + 'models/map').default;
    DiscourseReports.MeetupOpenEvent = require(PREFIX + 'models/meetup_open_event').default;

    require(PREFIX + 'routes/application').default;
    require(PREFIX + 'routes/discovery-homepage').default;
    require(PREFIX + 'routes/communities').default;
    require(PREFIX + 'routes/communities-events').default;
    require(PREFIX + 'routes/communities-groups').default;
    require(PREFIX + 'routes/communities-about').default;
    require(PREFIX + 'routes/login').default;
    require(PREFIX + 'routes/signup').default;
    require(PREFIX + 'routes/user-index').default;
    require(PREFIX + 'routes/community-request').default;
    require(PREFIX + 'routes/table-of-contents').default;
    require(PREFIX + 'routes/faq').default;
    require(PREFIX + 'routes/supporters').default;
    require(PREFIX + 'routes/contact').default;
    require(PREFIX + 'routes/discovery').default;
    require(PREFIX + 'routes/blogs').default;
    require(PREFIX + 'routes/topic-by-slug').default;
    require(PREFIX + 'routes/about').default;

    require(PREFIX + 'views/login').default;
    require(PREFIX + 'views/post').default;
    require(PREFIX + 'views/signup').default;
    require(PREFIX + 'views/topic').default;
    require(PREFIX + 'views/supporters').default;
    require(PREFIX + 'views/contributors').default;
    require(PREFIX + 'views/communities').default;
    require(PREFIX + 'views/community-request').default;
    require(PREFIX + 'views/contact').default;
    require(PREFIX + 'views/about-site').default;
    require(PREFIX + 'views/login-help').default;
    require(PREFIX + 'views/blogs').default;
    require(PREFIX + 'views/howtos').default;
  }
};
