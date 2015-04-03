module DiscourseReports
  class BlogsController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      params.permit(:offset, :limit)

      offset = [params[:offset].to_i, 0].max
      limit = [(params[:limit] || 10).to_i, 100].min

      serialized = serialize_data(topics(offset, limit), BlogSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('blogs_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def topics(offset=0, limit=10)
      Topic
        .includes(:category, :user, :_custom_fields)
        .where(archetype: 'blog')
        .order(created_at: :desc)
        .offset(offset)
        .limit(limit)
    end
  end
end
