module DiscourseReports
  module Meetup
    class Connection
      cattr_accessor :site
      self.site = "https://api.meetup.com"

      attr_reader :connection

      def initialize
        @connection ||= Faraday.new(url: self.class.site) do |builder|
          builder.use :http_cache, store: Rails.cache, serializer: Marshal
          builder.adapter :net_http
        end
      end

      def get(*args)
        result = connection.get(*args)
        result.success? ? result : ErrorResponse.new(result.body)
      end
    end
  end
end
