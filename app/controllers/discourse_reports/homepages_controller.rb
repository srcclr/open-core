module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr

    def show
      topic = Topic.select(:id, :slug).where(archetype: 'toc').first || Topic.new
      serialized = HomepageSerializer.new(topic, topics: topics, scope: guardian, root: false)

      respond_to do |format|
        format.html do
          store_preloaded('homepage',  MultiJson.dump(serialized))
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
