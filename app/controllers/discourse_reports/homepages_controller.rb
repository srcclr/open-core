module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr

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
      Topic.joins(:top_topic).where("top_topics.yearly_score > 0").includes(:category).where(
        categories: { name: SiteSetting.parent_categories.split('|') }
      ).order(TopicQuerySQL.order_top_for('yearly_score')).limit(15)
    end
  end
end
