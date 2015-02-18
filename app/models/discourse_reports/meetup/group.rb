module DiscourseReports
  module Meetup
    class Group

      def self.connection
        @@connection ||= Connection.new
      end

      def self.all(options = {})
        options = options.update(
          page: ::SiteSetting.meetup_max_results,
          key: ::SiteSetting.meetup_api_token,
          topic: ::SiteSetting.meetup_groups_topic,
          organizer_id: ::SiteSetting.meetup_groups_organizer_id
        )

        connection.get('/groups', options).body
      end
    end
  end
end
