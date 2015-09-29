module DiscourseReports
  class ChapterSerializer < ApplicationSerializer
    attributes :id, :name, :position, :href

    has_many :topics, serializer: SectionSerializer, embed: :objects

    def href
      object.topics.any? ? object.topics.first.relative_url : nil
    end
  end
end
