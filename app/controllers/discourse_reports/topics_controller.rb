module DiscourseReports
  class TopicsController < ::TopicsController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      topic = Topic.joins(:chapter).where(
        slug: params[:topic_slug].downcase,
        discourse_reports_chapters: { slug: params[:chapter_slug].downcase }
      ).first

      if topic
        redirect_to_correct_topic(topic, params[:post_number])
      else
        raise Discourse::NotFound
      end
    end
  end
end
