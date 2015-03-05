module DiscourseReports
  class ChapterSerializer < ApplicationSerializer
    attributes :id, :name, :position

    has_many :topics, serializer: BasicTopicSerializer, embed: :objects
  end
end
