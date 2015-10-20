module DiscourseReports
  class SectionSerializer < BasicTopicSerializer
    attributes :parent_topic_id, :relative_url
  end
end
