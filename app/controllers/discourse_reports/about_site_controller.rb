module DiscourseReports
  class AboutSiteController < StaticController
    def show
      @topic_view = TopicView.new(SiteSetting.guidelines_topic_id, current_user)
      respond_to do |format|
        format.html { render 'default/empty' }
        format.json { render_serialized(@topic_view, TopicViewSerializer, root: false) }
      end
    end
  end
end
