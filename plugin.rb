# name: Discourse reports
# about: Topic layouts based on archetype
# version: 0.0.1
# authors: Source Clear, Flatstack
require_relative 'lib/discourse_reports'
require_relative 'lib/archetype'

register_asset('stylesheets/comments.css.scss')

# Models
register_asset('javascripts/discourse/models/topic.js')

# Controllers
register_asset('javascripts/discourse/controllers/topic.js.es6')

# Views
register_asset('javascripts/discourse/views/post-menu.js.es6')

# Templates
register_asset('javascripts/discourse/templates/topic-admin-menu.hbs')


after_initialize do
  Archetype.register('book')
  Archetype.register('recipe')
end

Discourse::Application.routes.prepend do
  mount ::DiscourseReports::Engine, at: '/'
end
