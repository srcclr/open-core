module DiscourseReports
  module Meetup
    class ErrorResponse

      def initialize(body)
        @body = JSON.parse(body)
      end

      def body
        MultiJson.dump(results: [], meta: @body)
      end
    end
  end
end
