module DiscourseReports
  class BlogSerializer < TopicListItemSerializer
    has_one :first_post, serializer: BasicPostSerializer, embed: :objects

    def first_post
      object.posts[0]
    end
  end
end
