module DiscourseReports
  class HowtosController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      params.permit(:offset, :limit)

      serialized = serialize_data(topics, TopicListItemSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('howtos_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def topics
      topics_scope = Topic
        .includes(:category, :user, :_custom_fields)
        .where(archetype: 'how-to')

      PaginatedQuery.new(topics_scope, params).list
    end
  end
end
