module DiscourseReports
  class ChapterSerializer < ApplicationSerializer
    attributes :id, :name, :position

    has_many :topics, serializer: SectionSerializer, embed: :objects
  end
end
