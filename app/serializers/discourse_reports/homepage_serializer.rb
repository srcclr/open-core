module DiscourseReports
  class HomepageSerializer < ApplicationSerializer
    attributes :discussions

    private

    def discussions
      categories = options[:topics].group_by { |topic| topic.category.name }

      categories.each_with_object([]) do |(category_name, topics), result|
        result.push('name' => category_name, 'topics' => topics.map(&method(:serialize_topic)))
      end
    end

    def serialize_topic(topic)
      TopicHomepageSerializer.new(topic, scope: scope, root: false)
    end
  end
end
