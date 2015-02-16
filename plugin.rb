# name: Discourse reports
# about: Topic layouts based on archetype
# version: 0.0.1
# authors: Source Clear, Flatstack

gem 'acts_as_list', '0.6.0'

ADDITIONAL_USER_FIELDS = ['Company', 'Job title', 'Custom signature']

require(File.expand_path('../lib/discourse_reports', __FILE__))

register_asset('stylesheets/comments.css.scss')
register_asset('stylesheets/sections.css.scss')
register_asset('stylesheets/navigation.css.scss')
register_asset('stylesheets/part.css.scss')
register_asset('stylesheets/footer.css.scss')
register_asset('stylesheets/header.css.scss')
register_asset('stylesheets/views/landing.css.scss')
register_asset('stylesheets/views/login.css.scss')
register_asset('stylesheets/views/signup.css.scss')
register_asset('stylesheets/views/profile.css.scss')
register_asset('stylesheets/views/toc.css.scss')
register_asset('stylesheets/views/static.css.scss')

# Mixins
register_asset('javascripts/discourse/mixins/archetype-template.js.es6')

#Helpers
register_asset('javascripts/discourse/helpers/times.js.es6')
register_asset('javascripts/discourse/helpers/current-year.js.es6')

# Models
register_asset('javascripts/discourse/models/topic.js.es6')
register_asset('javascripts/discourse/models/composer.js.es6')
register_asset('javascripts/admin/models/part.js.es6')

# Controllers
register_asset('javascripts/discourse/controllers/topic.js.es6')
register_asset('javascripts/discourse/controllers/homepage.js.es6')
register_asset('javascripts/discourse/controllers/user/index.js.es6')
register_asset('javascripts/discourse/controllers/quote-button.js.es6')
register_asset('javascripts/admin/controllers/admin-toc.js.es6')
register_asset('javascripts/admin/controllers/admin-part.js.es6')

# Views
register_asset('javascripts/discourse/views/post-section-menu.js.es6')
register_asset('javascripts/discourse/views/post-part-menu.js.es6')
register_asset('javascripts/discourse/views/post.js.es6')
register_asset('javascripts/discourse/views/topic.js.es6')
register_asset('javascripts/discourse/views/signup.js.es6')
register_asset('javascripts/discourse/views/login.js.es6')
register_asset('javascripts/discourse/views/terms-of-use.js.es6')
register_asset('javascripts/discourse/views/supporters.js.es6')
register_asset('javascripts/discourse/views/contributors.js.es6')
register_asset('javascripts/discourse/views/privacy-policy.js.es6')
register_asset('javascripts/discourse/views/communities.js.es6')
register_asset('javascripts/discourse/views/contact.js.es6')
register_asset('javascripts/discourse/views/about-site.js.es6')
register_asset('javascripts/admin/views/admin-toc.js.es6')
register_asset('javascripts/admin/views/admin-part.js.es6')

# Components
register_asset('javascripts/discourse/components/bread-crumbs.js.es6')

# Templates
register_asset('javascripts/discourse/templates/topic-admin-menu.hbs')
register_asset('javascripts/discourse/templates/topic-section.hbs')
register_asset('javascripts/discourse/templates/topic-recipe.hbs')
register_asset('javascripts/discourse/templates/topic-toc.hbs')
register_asset('javascripts/discourse/templates/post-section.hbs')
register_asset('javascripts/discourse/templates/post-recipe.hbs')
register_asset('javascripts/discourse/templates/post-toc.hbs')
register_asset('javascripts/discourse/templates/homepage.hbs')
register_asset('javascripts/discourse/templates/footer.hbs')
register_asset('javascripts/discourse/templates/header.hbs')
register_asset('javascripts/discourse/templates/signup.hbs')
register_asset('javascripts/discourse/templates/login.hbs')
register_asset('javascripts/discourse/templates/components/user-fields/text.hbs')
register_asset('javascripts/discourse/templates/components/bread-crumbs.hbs')
register_asset('javascripts/discourse/templates/user/index.hbs')
register_asset('javascripts/discourse/templates/user/user.hbs')
register_asset('javascripts/discourse/templates/user/recipes.hbs')
register_asset('javascripts/discourse/templates/user/notifications.hbs')
register_asset('javascripts/discourse/templates/terms-of-use.hbs')
register_asset('javascripts/discourse/templates/supporters.hbs')
register_asset('javascripts/discourse/templates/contributors.hbs')
register_asset('javascripts/discourse/templates/privacy-policy.hbs')
register_asset('javascripts/discourse/templates/communities.hbs')
register_asset('javascripts/discourse/templates/contact.hbs')
register_asset('javascripts/discourse/templates/about-site.hbs')
register_asset('javascripts/discourse/templates/discovery.hbs')
register_asset('javascripts/discourse/templates/composer.hbs')
register_asset('javascripts/admin/templates/admin.hbs')
register_asset('javascripts/admin/templates/toc.hbs')

# Routes
register_asset('javascripts/discourse/routes/app-route-map.js.es6')
register_asset('javascripts/discourse/routes/discovery-homepage.js.es6')
register_asset('javascripts/discourse/routes/application.js.es6')
register_asset('javascripts/discourse/routes/signup.js.es6')
register_asset('javascripts/discourse/routes/login.js.es6')
register_asset('javascripts/discourse/routes/user-index.js.es6')
register_asset('javascripts/admin/routes/admin-toc.js.es6')

# BBCode
register_asset('javascripts/discourse/dialects/navigation_bbcode.js', :server_side)
register_asset('javascripts/discourse/dialects/part_bbcode.js', :server_side)

after_initialize do
  #require(File.expand_path('../app/services/discourse_reports/generate_table_content', __FILE__))

  require(File.expand_path('../lib/archetype', __FILE__))
  require(File.expand_path('../lib/post_revisor', __FILE__))
  require(File.expand_path('../lib/preload_parts', __FILE__))
  require(File.expand_path('../app/serializers/topic_view_serializer', __FILE__))
  require(File.expand_path('../app/serializers/site_serializer', __FILE__))
  require(File.expand_path('../app/models/topic', __FILE__))

  PreloadParts.preload
  DiscourseReports::Part.update_part_constraints

  Archetype.register('toc')
  Archetype.register('recipe')
  Archetype.register('section')

  SiteSetting.top_menu = "homepage|" << SiteSetting.top_menu
  SiteSetting.logo_url = ActionController::Base.helpers.image_path('logo-discourse-reports.png')

  ADDITIONAL_USER_FIELDS.each do |field_name|
    field = UserField.find_or_initialize_by(name: field_name)
    field.update(description: field_name, field_type: 'text', editable: true, required: false)
  end

  SiteSetting.parent_categories.split('|').each do |category|
    Category.create!(name: category, user_id: -1) unless Category.find_by(name: category)
  end

  topic = Topic.select(:id, :slug).where(archetype: 'toc').first || Topic.new
  SiteSetting.link_to_table_of_content = "/t/#{topic.slug}/#{topic.id}"
end

Discourse::Application.routes.prepend do
  mount ::DiscourseReports::Engine, at: '/'

  get 'users/:username/recipes' => 'users#show'
end
