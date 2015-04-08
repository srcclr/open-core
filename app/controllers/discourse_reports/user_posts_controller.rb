module DiscourseReports
  class UserPostsController < ::ApplicationController
    before_filter :ensure_logged_in, :ensure_can_see_category

    def index
      params.permit(:offset, :limit, :archetype)

      user = fetch_user_from_params
      offset = [params[:offset].to_i, 0].max
      limit = [(params[:limit] || 60).to_i, 100].min

      render_serialized(
        user_posts(user.id, offset, limit),
        ::AdminPostSerializer
      )
    end

    private

    def user_posts(user_id, offset=0, limit=60)
      Post.includes(:user, :topic, :deleted_by, :user_actions)
        .where(user_id: user_id, topics: { archetype: params[:archetype].singularize })
        .order(created_at: :desc)
        .offset(offset)
        .limit(limit)
    end

    def ensure_can_see_category
      category = Category.find_by_slug(params[:archetype].singularize)
      category && guardian.ensure_can_see!(category)
    end
  end
end
