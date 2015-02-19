module DiscourseReports
  module Meetup
    class OpenEvent

      def self.connection
        @@connection ||= Connection.new
      end

      def self.all(options = {})
        options = options.update(
          page: ::SiteSetting.meetup_max_results,
          key: ::SiteSetting.meetup_api_token
        )

        if(::SiteSetting.meetup_groups_topic.presence)
          options.merge!(topic: ::SiteSetting.meetup_groups_topic)
        end

        connection.get('/2/open_events', options).body
      end
    end
  end
end
