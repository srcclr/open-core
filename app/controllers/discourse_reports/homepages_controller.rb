module DiscourseReports
  class HomepagesController < ApplicationController
    skip_before_filter :check_xhr

    def show
      topic = TopicHomepageSerializer.new(
        (Topic.includes(:posts).where(archetype: 'toc').first || Topic.new),
        scope: guardian,
        root: false
      )

      respond_to do |format|
        format.html do
          store_preloaded('homepage',  MultiJson.dump(topic))
          render 'default/empty'
        end

        format.json { render_json_dump(topic) }
      end
    end
  end
end
