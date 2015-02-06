module DiscourseReports
  class TopicHomepageSerializer < BasicTopicSerializer
    attributes :participant_count, :last_posted_at
    has_one :category, serializer: CategoryDetailedSerializer
  end
end
