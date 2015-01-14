# name: Discourse reports
# about: Topic layouts based on archetype
# version: 0.0.1
# authors: Source Clear, Flatstack
require(File.expand_path('../lib/discourse_reports', __FILE__))

register_asset('stylesheets/comments.css.scss')
register_asset('stylesheets/books.css.scss')
register_asset('stylesheets/navigation.css.scss')
register_asset('stylesheets/part.css.scss')

# Mixins
register_asset('javascripts/discourse/mixins/archetype-template.js.es6')

# Models
register_asset('javascripts/discourse/models/topic.js.es6')

# Controllers
register_asset('javascripts/discourse/controllers/topic.js.es6')

# Views
register_asset('javascripts/discourse/views/post-book-menu.js.es6')
register_asset('javascripts/discourse/views/post_view.js.es6')
register_asset('javascripts/discourse/views/topic.js.es6')

# Templates
register_asset('javascripts/discourse/templates/topic-admin-menu.hbs')
register_asset('javascripts/discourse/templates/topic-book.hbs')
register_asset('javascripts/discourse/templates/topic-part.hbs')
register_asset('javascripts/discourse/templates/post-book.hbs')
register_asset('javascripts/discourse/templates/post-part.hbs')

# BBCode
register_asset('javascripts/discourse/dialects/navigation_bbcode.js', :server_side)
register_asset('javascripts/discourse/dialects/part_bbcode.js', :server_side)

after_initialize do
  require(File.expand_path('../lib/archetype', __FILE__))

  Archetype.register('book')
  Archetype.register('part')
end

Discourse::Application.routes.prepend do
  mount ::DiscourseReports::Engine, at: '/'
end
