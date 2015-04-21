module DiscourseReports
  class SectionsController < ::ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      params.permit(:chapter_id)

      serialized = serialize_data(topics, BasicTopicSerializer, root: false)

      render_json_dump(serialized)
    end

    private

    def topics
      Topic.where(archetype: 'section', chapter_id: params[:chapter_id])
    end
  end
end
