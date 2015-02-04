module DiscourseReports
  class TopicHomepageSerializer < BasicTopicSerializer
    attributes :participant_count, :last_posted_at
  end
end
