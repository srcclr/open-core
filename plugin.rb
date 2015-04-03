# name: Discourse reports
# about: Topic layouts based on archetype
# version: 0.0.1
# authors: Source Clear, Flatstack

gem 'acts_as_list', '0.6.0'
gem 'faraday-http-cache', '1.0.1'
gem 'geoip', '1.4.0'
gem 'secure_headers', '2.0.0'

ADDITIONAL_USER_FIELDS = ['Company', 'Job title', 'Custom signature']

require(File.expand_path('../lib/discourse_reports', __FILE__))

register_asset('stylesheets/base/base.css.scss')
register_asset('stylesheets/base/form.css.scss')
register_asset('stylesheets/base/grid.css.scss')

register_asset('stylesheets/components/comments.css.scss')
register_asset('stylesheets/components/sections.css.scss')
register_asset('stylesheets/components/part.css.scss')
register_asset('stylesheets/components/map.css.scss')

register_asset('stylesheets/shared/footer.css.scss')
register_asset('stylesheets/shared/header.css.scss')
register_asset('stylesheets/shared/navigation.css.scss')

register_asset('stylesheets/views/landing.css.scss')
register_asset('stylesheets/views/login.css.scss')
register_asset('stylesheets/views/signup.css.scss')
register_asset('stylesheets/views/profile.css.scss')
register_asset('stylesheets/views/toc.css.scss')
register_asset('stylesheets/views/static.css.scss')
register_asset('stylesheets/views/recipes.css.scss')
register_asset('stylesheets/views/communities.css.scss')
register_asset('stylesheets/views/founders.css.scss')
register_asset('stylesheets/views/blog-posts-list.css.scss')
register_asset('stylesheets/vendor/bootstrap-datepicker.css.scss')

# Mixins
register_asset('javascripts/discourse/mixins/archetype-template.js.es6')
register_asset('javascripts/discourse/mixins/url-sanitizer.js.es6')
register_asset('javascripts/discourse/mixins/reply-settings.js.es6')
register_asset('javascripts/discourse/mixins/recipe-languages-technologies.js.es6')

# Helpers
register_asset('javascripts/discourse/helpers/times.js.es6')
register_asset('javascripts/discourse/helpers/current-year.js.es6')
register_asset('javascripts/discourse/helpers/formatted-date.js.es6')

# Models
register_asset('javascripts/discourse/models/topic.js.es6')
register_asset('javascripts/discourse/models/composer.js.es6')
register_asset('javascripts/discourse/models/map.js.es6')
register_asset('javascripts/discourse/models/meetup_open_event.js.es6')
register_asset('javascripts/discourse/models/recipe.js.es6')

# Controllers
register_asset('javascripts/discourse/controllers/topic.js.es6')
register_asset('javascripts/discourse/controllers/recipe.js.es6')
register_asset('javascripts/discourse/controllers/communities.js.es6')
register_asset('javascripts/discourse/controllers/communities-events.js.es6')
register_asset('javascripts/discourse/controllers/communities-groups.js.es6')
register_asset('javascripts/discourse/controllers/homepage.js.es6')
register_asset('javascripts/discourse/controllers/user-index.js.es6')
register_asset('javascripts/discourse/controllers/quote-button.js.es6')
register_asset('javascripts/discourse/controllers/community-request.js.es6')
register_asset('javascripts/discourse/controllers/communities-about.js.es6')
register_asset('javascripts/discourse/controllers/login.js.es6')
register_asset('javascripts/discourse/controllers/login-help.js.es6')
register_asset('javascripts/discourse/controllers/navigation/category.js.es6')
register_asset('javascripts/discourse/controllers/recipe-form.js.es6')
register_asset('javascripts/discourse/controllers/blogs.js.es6')

# Views
register_asset('javascripts/discourse/views/post-section-menu.js.es6')
register_asset('javascripts/discourse/views/post-part-menu.js.es6')
register_asset('javascripts/discourse/views/post-recipe-menu.js.es6')
register_asset('javascripts/discourse/views/post.js.es6')
register_asset('javascripts/discourse/views/topic.js.es6')
register_asset('javascripts/discourse/views/signup.js.es6')
register_asset('javascripts/discourse/views/login.js.es6')
register_asset('javascripts/discourse/views/supporters.js.es6')
register_asset('javascripts/discourse/views/contributors.js.es6')
register_asset('javascripts/discourse/views/communities.js.es6')
register_asset('javascripts/discourse/views/community-request.js.es6')
register_asset('javascripts/discourse/views/contact.js.es6')
register_asset('javascripts/discourse/views/about-site.js.es6')
register_asset('javascripts/discourse/views/login-help.js.es6')
register_asset('javascripts/discourse/views/blogs.js.es6')

# Components
register_asset('javascripts/discourse/components/bread-crumbs.js.es6')
register_asset('javascripts/discourse/components/google-maps.js.es6')
register_asset('javascripts/discourse/components/maps-filters.js.es6')
register_asset('javascripts/discourse/components/tags-checkbox.js.es6')

# Plugins
register_asset "javascripts/vendor/bootstrap-datepicker.js"

# Templates
register_asset('javascripts/discourse/templates/topic-admin-menu.hbs')
register_asset('javascripts/discourse/templates/topic-section.hbs')
register_asset('javascripts/discourse/templates/topic-recipe.hbs')
register_asset('javascripts/discourse/templates/topic-toc.hbs')
register_asset('javascripts/discourse/templates/topic-blog.hbs')
register_asset('javascripts/discourse/templates/post-section.hbs')
register_asset('javascripts/discourse/templates/post-recipe.hbs')
register_asset('javascripts/discourse/templates/post-toc.hbs')
register_asset('javascripts/discourse/templates/post-blog.hbs')
register_asset('javascripts/discourse/templates/homepage.hbs')
register_asset('javascripts/discourse/templates/footer.hbs')
register_asset('javascripts/discourse/templates/header.hbs')
register_asset('javascripts/discourse/templates/signup.hbs')
register_asset('javascripts/discourse/templates/login.hbs')
register_asset('javascripts/discourse/templates/components/user-fields/text.hbs')
register_asset('javascripts/discourse/templates/components/bread-crumbs.hbs')
register_asset('javascripts/discourse/templates/components/tags-checkbox.hbs')
register_asset('javascripts/discourse/templates/components/login-buttons.hbs')
register_asset('javascripts/discourse/templates/user/index.hbs')
register_asset('javascripts/discourse/templates/user/user.hbs')
register_asset('javascripts/discourse/templates/user/blogs.hbs')
register_asset('javascripts/discourse/templates/user/notifications.hbs')
register_asset('javascripts/discourse/templates/supporters.hbs')
register_asset('javascripts/discourse/templates/contributors.hbs')
register_asset('javascripts/discourse/templates/communities.hbs')
register_asset('javascripts/discourse/templates/community-request.hbs')
register_asset('javascripts/discourse/templates/contact.hbs')
register_asset('javascripts/discourse/templates/about-site.hbs')
register_asset('javascripts/discourse/templates/discovery.hbs')
register_asset('javascripts/discourse/templates/composer.hbs')
register_asset('javascripts/discourse/templates/communities/about.hbs')
register_asset('javascripts/discourse/templates/communities/results.hbs')
register_asset('javascripts/discourse/templates/modal/forgot_password.hbs')
register_asset('javascripts/discourse/templates/modal/login_help.hbs')
register_asset('javascripts/discourse/templates/navigation/category.hbs')
register_asset('javascripts/discourse/templates/recipe-form.hbs')
register_asset('javascripts/discourse/templates/blogs.hbs')

# Routes
register_asset('javascripts/discourse/routes/app-route-map.js.es6')
register_asset('javascripts/discourse/routes/discovery-homepage.js.es6')
register_asset('javascripts/discourse/routes/application.js.es6')
register_asset('javascripts/discourse/routes/signup.js.es6')
register_asset('javascripts/discourse/routes/login.js.es6')
register_asset('javascripts/discourse/routes/user-index.js.es6')
register_asset('javascripts/discourse/routes/community-request.js.es6')
register_asset('javascripts/discourse/routes/table-of-contents.js.es6')
register_asset('javascripts/discourse/routes/topic-by-friendly.js.es6')
register_asset('javascripts/discourse/routes/supporters.js.es6')
register_asset('javascripts/discourse/routes/contact.js.es6')
register_asset('javascripts/discourse/routes/about-site.js.es6')
register_asset('javascripts/discourse/routes/communities.js.es6')
register_asset('javascripts/discourse/routes/communities-events.js.es6')
register_asset('javascripts/discourse/routes/communities-groups.js.es6')
register_asset('javascripts/discourse/routes/communities-about.js.es6')
register_asset('javascripts/discourse/routes/faq.js.es6')
register_asset('javascripts/discourse/routes/discovery.js.es6')
register_asset('javascripts/discourse/routes/recipes-new.js.es6')
register_asset('javascripts/discourse/routes/recipes-edit.js.es6')
register_asset('javascripts/discourse/routes/blogs.js.es6')
register_asset('javascripts/discourse/routes/user-recipes.js.es6')
register_asset('javascripts/discourse/routes/user-blogs.js.es6')
register_asset('javascripts/discourse/routes/topic-by-slug.js.es6')

# BBCode
register_asset('javascripts/discourse/dialects/navigation_bbcode.js', :server_side)
register_asset('javascripts/discourse/dialects/part_bbcode.js', :server_side)

# Admin
register_asset('stylesheets/admin/toc.css.scss', :admin)
register_asset('javascripts/admin/models/part.js.es6', :admin)
register_asset('javascripts/admin/models/chapter.js.es6', :admin)
register_asset('javascripts/admin/models/section.js.es6', :admin)
register_asset('javascripts/admin/controllers/admin-toc.js.es6', :admin)
register_asset('javascripts/admin/controllers/admin-part.js.es6', :admin)
register_asset('javascripts/admin/controllers/admin-chapter.js.es6', :admin)
register_asset('javascripts/admin/views/admin.js.es6', :admin)
register_asset('javascripts/admin/views/admin-toc.js.es6', :admin)
register_asset('javascripts/admin/views/admin-part.js.es6', :admin)
register_asset('javascripts/admin/views/admin-chapter.js.es6', :admin)
register_asset('javascripts/admin/templates/admin.hbs', :admin)
register_asset('javascripts/admin/templates/toc.hbs', :admin)
register_asset('javascripts/admin/routes/admin-toc.js.es6', :admin)
register_asset('javascripts/admin/initializer.js', :admin)

def initialize_additional_libs
  require(File.expand_path('../lib/archetype', __FILE__))
  require(File.expand_path('../lib/post_revisor', __FILE__))
  require(File.expand_path('../lib/preload_parts', __FILE__))
  require(File.expand_path('../lib/recipe_constraint', __FILE__))
  require(File.expand_path('../app/serializers/topic_view_serializer', __FILE__))
  require(File.expand_path('../app/serializers/site_serializer', __FILE__))
  require(File.expand_path('../app/serializers/current_user_serializer', __FILE__))
  require(File.expand_path('../app/serializers/topic_list_item_serializer', __FILE__))
  require(File.expand_path('../app/models/topic', __FILE__))
  require(File.expand_path('../app/jobs/request_email', __FILE__))
  require(File.expand_path('../app/mailers/request_mailer', __FILE__))
  require(File.expand_path('../app/mailers/invite_mailer', __FILE__))
  require(File.expand_path('../app/mailers/user_notifications', __FILE__))
  require(File.expand_path('../app/controllers/application_controller', __FILE__))

  ADDITIONAL_USER_FIELDS.each do |field_name|
    field = UserField.find_or_initialize_by(name: field_name)
    field.update(description: field_name, field_type: 'text', editable: true, required: false)
  end

  SiteSetting.parent_categories.split('|').each do |category|
    Category.create!(name: category, user_id: -1) unless Category.find_by(name: category)
  end

  topic = Topic.select(:id, :slug).where(archetype: 'toc').first || Topic.new
  SiteSetting.link_to_table_of_content = "/t/#{topic.slug}/#{topic.id}"
  SiteSetting.meetup_help_popup_image_url = ActionController::Base.helpers.image_path('meetup_id.png')

rescue ActiveRecord::StatementInvalid => exception
  raise exception unless exception.message.include?('PG::UndefinedTable')
end

after_initialize do
  initialize_additional_libs

  Dir[File.expand_path('../config/initializers/**/*.rb', __FILE__)].each do |file|
    require file
  end

  Archetype.register('toc')
  Archetype.register('recipe')
  Archetype.register('section')
  Archetype.register('blog')

  top_menu = SiteSetting.top_menu
  top_menu = 'homepage|' << top_menu unless top_menu.include? 'homepage'
  filters = Discourse.filters + [:top]

  SiteSetting.top_menu = top_menu.split('|').map do |menu_item|
    filters.include?(menu_item.to_sym) ? menu_item << ',-Book' : menu_item
  end.join('|')

  SiteSetting.logo_url = ActionController::Base.helpers.image_path('logo-discourse-reports.png')
  SiteSetting.logo_small_url = ActionController::Base.helpers.image_path('logo-discourse-reports-small.png')
  SiteSetting.favicon_url = ActionController::Base.helpers.image_path('favicon-cs.ico')
  SiteSetting.apple_touch_icon_url = ActionController::Base.helpers.image_path('cs-apple-touch-icon.png')

  SiteText.add_text_type :login_page_text, default_18n_key: 'pages.login.text_body_template'
  SiteText.add_text_type :request_community_page_text, default_18n_key: 'pages.request_community.text_body_template'
  SiteText.add_text_type :login_help, default_18n_key: 'popup.login_help.text_body_template'
  SiteText.add_text_type :invite_email_title, default_18n_key: 'invite_forum_mailer.subject_template'
  SiteText.add_text_type :invite_email, default_18n_key: 'invite_forum_mailer.text_body_template'
  SiteText.add_text_type :invite_password_instructions, default_18n_key: 'invite_password_instructions.text_body_template'
  SiteText.add_text_type :forgot_password, default_18n_key: 'user_notifications.forgot_password.text_body_template'
  SiteText.add_text_type :set_password, default_18n_key: 'user_notifications.set_password.text_body_template'
end

Discourse::Application.routes.prepend do
  mount ::DiscourseReports::Engine, at: '/'
end
