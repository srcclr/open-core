module DiscourseReports
  class TopicUrlsController < ::ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      guardian.ensure_can_see!(topic)

      raise Discourse::NotFound unless topic
      serialized = { slug: topic.slug, topic_url: topic.id, url: topic.url }

      respond_to do |format|
        format.html do
          store_preloaded('topic_id',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render json: serialized }
      end
    end

    private


    def topic
      @topic ||= Topic.where(categories: { slug: params[:category_slug] })
        .joins(:category)
        .find_by(slug: params[:slug].downcase)
    end
  end
end
