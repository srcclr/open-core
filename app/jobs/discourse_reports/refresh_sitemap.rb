require "sitemap_generator"
require "sitemap_generator/tasks"

ENV["CONFIG_FILE"] = "plugins/open-core/config/sitemap.rb"

module Jobs
  module DiscourseReports
    class RefreshSitemap < Jobs::Scheduled
      every 1.week

      def execute(_args)
        Discourse::Application.load_tasks
        Rake.application["sitemap:refresh"].invoke
      end
    end
  end
end
