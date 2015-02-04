module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr

    def show
      topic = BasicTopicSerializer.new(
        (Topic.includes(:posts).where(archetype: 'toc').first || Topic.new),
        scope: guardian,
        root: false
      )

      discussions = []
      categories = ['Process', 'Design/Architecture', 'Coding', 'Testing/QA', 'Monitoring']
      Category.where('name IN (?)', categories).map do |category|
        topics = category.topics.top_viewed(3).map do |topic|
          TopicHomepageSerializer.new(topic, scope: guardian, root: false)
        end
        discussions << { name: category.name, topics: topics } unless topics.empty?
      end

      serialized = { toc_topic: topic, discussions: discussions }

      respond_to do |format|
        format.html do
          store_preloaded('homepage',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end
  end
end
