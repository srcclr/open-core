module DiscourseReports
  class BlogSerializer < TopicListItemSerializer
    has_one :first_post, serializer: AdminPostSerializer, embed: :objects
  end
end
