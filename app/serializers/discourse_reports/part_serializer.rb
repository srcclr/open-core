module DiscourseReports
  class PartSerializer < ApplicationSerializer
    attributes :id, :name, :position, :description

    has_many :chapters, serializer: ChapterSerializer, embed: :objects
  end
end
