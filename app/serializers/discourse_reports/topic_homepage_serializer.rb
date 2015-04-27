module DiscourseReports
  class TopicHomepageSerializer < TopicListItemSerializer
    has_one :category, serializer: CategoryDetailedSerializer, embed: :objects
  end
end
