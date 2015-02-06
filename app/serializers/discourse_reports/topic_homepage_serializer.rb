module DiscourseReports
  class TopicHomepageSerializer < TopicListItemSerializer
    has_one :category, serializer: CategoryDetailedSerializer
  end
end
