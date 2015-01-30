# name: Discourse reports
# about: Topic layouts based on archetype
# version: 0.0.1
# authors: Source Clear, Flatstack

ADDITIONAL_USER_FIELDS = ['Company', 'Job title', 'Custom signature']

require(File.expand_path('../lib/discourse_reports', __FILE__))

register_asset('stylesheets/comments.css.scss')
register_asset('stylesheets/sections.css.scss')
register_asset('stylesheets/navigation.css.scss')
register_asset('stylesheets/part.css.scss')
register_asset('stylesheets/footer.css.scss')
register_asset('stylesheets/header.css.scss')
register_asset('stylesheets/views/login.css.scss')
register_asset('stylesheets/views/profile.css.scss')
register_asset('stylesheets/views/signup.css.scss')
register_asset('stylesheets/views/landing.css.scss')

# Mixins
register_asset('javascripts/discourse/mixins/archetype-template.js.es6')

#Helpers
register_asset('javascripts/discourse/helpers/current-year.js.es6')

# Models
register_asset('javascripts/discourse/models/topic.js.es6')

# Controllers
register_asset('javascripts/discourse/controllers/topic.js.es6')
register_asset('javascripts/discourse/controllers/homepage.js.es6')
register_asset('javascripts/discourse/controllers/user/index.js.es6')
register_asset('javascripts/discourse/controllers/quote-button.js.es6')

# Views
register_asset('javascripts/discourse/views/post-section-menu.js.es6')
register_asset('javascripts/discourse/views/post-part-menu.js.es6')
register_asset('javascripts/discourse/views/post_view.js.es6')
register_asset('javascripts/discourse/views/topic.js.es6')
register_asset('javascripts/discourse/views/homepage.js.es6')
register_asset('javascripts/discourse/views/signup.js.es6')
register_asset('javascripts/discourse/views/login.js.es6')

# Templates
register_asset('javascripts/discourse/templates/topic-admin-menu.hbs')
register_asset('javascripts/discourse/templates/topic-section.hbs')
register_asset('javascripts/discourse/templates/topic-part.hbs')
register_asset('javascripts/discourse/templates/post-section.hbs')
register_asset('javascripts/discourse/templates/post-part.hbs')
register_asset('javascripts/discourse/templates/homepage.hbs')
register_asset('javascripts/discourse/templates/footer.hbs')
register_asset('javascripts/discourse/templates/header.hbs')
register_asset('javascripts/discourse/templates/signup.hbs')
register_asset('javascripts/discourse/templates/login.hbs')
register_asset('javascripts/discourse/templates/components/user-fields/text.hbs')
register_asset('javascripts/discourse/templates/user/index.hbs')
register_asset('javascripts/discourse/templates/user/user.hbs')

# Routes
register_asset('javascripts/discourse/routes/app-route-map.js.es6')
register_asset('javascripts/discourse/routes/discovery-homepage-route.js.es6')
register_asset('javascripts/discourse/routes/discovery-route.js.es6')
register_asset('javascripts/discourse/routes/application.js.es6')
register_asset('javascripts/discourse/routes/signup.js.es6')
register_asset('javascripts/discourse/routes/login.js.es6')
register_asset('javascripts/discourse/routes/user-index.js.es6')

# BBCode
register_asset('javascripts/discourse/dialects/navigation_bbcode.js', :server_side)
register_asset('javascripts/discourse/dialects/part_bbcode.js', :server_side)

after_initialize do
  require(File.expand_path('../lib/archetype', __FILE__))

  Archetype.register('toc')
  Archetype.register('part')
  Archetype.register('section')

  SiteSetting.top_menu = "homepage|" << SiteSetting.top_menu
  SiteSetting.logo_url = ActionController::Base.helpers.image_path('logo-discourse-reports.png')
  SiteSetting.seamless_integration_url = ActionController::Base.helpers.image_path(
    SiteSetting.seamless_integration_url
  )

  ADDITIONAL_USER_FIELDS.each do |field_name|
    field = UserField.find_or_initialize_by(name: field_name)
    field.update(description: field_name, field_type: 'text', editable: true, required: false)
  end
end

Discourse::Application.routes.prepend do
  mount ::DiscourseReports::Engine, at: '/'
end
