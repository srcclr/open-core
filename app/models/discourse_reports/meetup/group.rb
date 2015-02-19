module DiscourseReports
  module Meetup
    class Group

      def self.connection
        @@connection ||= Connection.new
      end

      def self.all(options = {})
        options = options.update(
          page: ::SiteSetting.meetup_max_results,
          key: ::SiteSetting.meetup_api_token
        )

        if (::SiteSetting.meetup_groups_topic.presence && ::SiteSetting.meetup_groups_organizer_id.presence)
          options.merge!({
            topic: ::SiteSetting.meetup_groups_topic,
            organizer_id: ::SiteSetting.meetup_groups_organizer_id
          })
        end

        connection.get('/2/groups', options).body
      end
    end
  end
end
