module DiscourseReports
  class AboutSiteController < ApplicationController
    skip_before_filter :check_xhr, only: [:show]

    def show
      @topic_view = TopicView.new(SiteSetting.guidelines_topic_id, current_user)
      respond_to do |format|
        format.html { render 'default/empty' }
        format.json { render_serialized(@topic_view, TopicViewSerializer, root: false) }
      end
    end
  end
end
