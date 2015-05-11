module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      serialized = serialize_data(topics, TopicHomepageSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('homepage_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def topics
      Topic
        .joins(:top_topic, :category)
        .order('top_topics.all_score DESC')
        .where.not(archetype: Archetype::TABLE_OF_CONTENTS)
        .limit(5)
    end
  end
end
