module DiscourseReports
  class TopicHomepageSerializer < ApplicationSerializer

    attributes :id, :title, :post_stream

    def post_stream
      object.posts.map do |post|
        PostSerializer.new(post, scope: scope, root: false)
      end
    end
  end
end
