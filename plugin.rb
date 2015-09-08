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

register_asset('stylesheets/admin/settings.css.scss')

register_asset('stylesheets/base/base.css.scss')

register_asset('stylesheets/components/comments.css.scss')
register_asset('stylesheets/components/sections.css.scss')
register_asset('stylesheets/components/part.css.scss')
register_asset('stylesheets/components/map.css.scss')
register_asset('stylesheets/components/share.css.scss')
register_asset('stylesheets/components/related.css.scss')
register_asset('stylesheets/components/filters.css.scss')
register_asset('stylesheets/components/table.css.scss')

register_asset('stylesheets/shared/footer.css.scss')
register_asset('stylesheets/shared/header.css.scss')
register_asset('stylesheets/shared/navigation.css.scss')

register_asset('stylesheets/views/landing.css.scss')
register_asset('stylesheets/views/login.css.scss')
register_asset('stylesheets/views/signup.css.scss')
register_asset('stylesheets/views/profile.css.scss')
register_asset('stylesheets/views/toc.css.scss')
register_asset('stylesheets/views/static.css.scss')
register_asset('stylesheets/views/howtos.css.scss')
register_asset('stylesheets/views/communities.css.scss')
register_asset('stylesheets/views/founders.css.scss')
register_asset('stylesheets/views/blog-posts-list.css.scss')
register_asset('stylesheets/views/blog-post.css.scss')
register_asset('stylesheets/views/howto.css.scss')
register_asset('stylesheets/views/topic-post.css.scss')
register_asset('stylesheets/vendor/bootstrap-datepicker.css.scss')

register_asset('javascripts/vendor/bootstrap-datepicker.js')

# BBCode
register_asset('javascripts/discourse/dialects/navigation_bbcode.js', :server_side)
register_asset('javascripts/discourse/dialects/part_bbcode.js', :server_side)

# Admin
register_asset('stylesheets/admin/toc.css.scss', :admin)
register_asset('stylesheets/admin/base.css.scss', :admin)
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
register_asset('javascripts/admin/templates/site-settings/textarea.hbs', :admin)
register_asset('javascripts/admin/routes/admin-toc.js.es6', :admin)
register_asset('javascripts/admin/initializer.js', :admin)

def predefined_categories
  SiteSetting.parent_categories.split('|') | ['Blogs', 'How-Tos']
end

def initialize_additional_libs
  require(File.expand_path('../lib/archetype', __FILE__))
  require(File.expand_path('../lib/post_revisor', __FILE__))
  require(File.expand_path('../lib/preload_parts', __FILE__))
  require(File.expand_path('../lib/suggested_topics_builder', __FILE__))
  require(File.expand_path('../lib/search', __FILE__))
  require(File.expand_path('../lib/guardian', __FILE__))
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

  predefined_categories.each do |category|
    Category.create!(name: category, user_id: -1) unless Category.find_by(name: category)
  end

rescue ActiveRecord::StatementInvalid => exception
  raise exception unless exception.message.include?('PG::UndefinedTable')
end

after_initialize do
  initialize_additional_libs

  Dir[File.expand_path('../config/initializers/**/*.rb', __FILE__)].each do |file|
    require file
  end

  Archetype.register('toc')
  Archetype.register('how-to')

  Archetype.register('section')
  Archetype.register('blog')

  top_menu = SiteSetting.top_menu
  top_menu = 'homepage|' << top_menu unless top_menu.include? 'homepage'
  filters = Discourse.filters + [:top]

  SiteSetting.top_menu = top_menu.split('|').map do |menu_item|
    filters.include?(menu_item.to_sym) ? menu_item << ',-Book' : menu_item
  end.join('|')

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

Discourse::Application.routes.append do
  get '/:part_slug/:chapter_slug/:topic_slug',
    to: 'discourse_reports/topics#show',
    as: :part_chapter_topic,
    constraints: DiscourseReports::PartChapterTopicConstraint.new
end
