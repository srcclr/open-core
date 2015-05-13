module DiscourseReports
  class AboutController < ApplicationController
    skip_before_filter :check_xhr, only: [:show]

    def show
      @topic_view = TopicView.new(SiteSetting.guidelines_topic_id, current_user)
      render_serialized(@topic_view, TopicViewSerializer, root: false)
    end
  end
end
