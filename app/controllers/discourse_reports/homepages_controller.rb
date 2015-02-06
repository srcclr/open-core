module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr

    def show
      serialized = serialize_data(topics, TopicHomepageSerializer, scope: guardian)

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
      Topic.includes(:category).top_viewed(3).where(
        categories: { name: SiteSetting.parent_categories.split('|') }
      )
    end
  end
end
