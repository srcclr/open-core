module DiscourseReports
  class AboutSiteController < StaticController
    before_filter :redirect_to_login_if_required

    def show
      @topic_view = TopicView.new(SiteSetting.guidelines_topic_id, current_user)
      respond_to do |format|
        format.html { render 'default/empty' }
        format.json { render_serialized(@topic_view, TopicViewSerializer, root: false) }
      end
    end
  end
end
