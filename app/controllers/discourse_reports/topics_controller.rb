module DiscourseReports
  class TopicsController < ::TopicsController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      serialized = { url: topic.url }

      respond_to do |format|
        format.html do
          store_preloaded('topic_url',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render json: serialized }
      end
    end

    private

    def topic
      Topic.joins(chapter: :part).where(
        discourse_reports_parts: { slug: params[:part_slug] },
        discourse_reports_chapters: { slug: params[:chapter_slug] },
        slug: params[:topic_slug]
      ).first!
    end
  end
end
