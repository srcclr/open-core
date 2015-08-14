module DiscourseReports
  class TaxonomiesSerializer < ApplicationSerializer
    attributes :can_create_topic, :available_letters

    has_many :taxonomies, serializer: TopicListItemSerializer, embed: :objects

    delegate :available_letters, to: :object

    private

    def can_create_topic
      scope.can_create?(Topic)
    end
  end
end
