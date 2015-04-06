module DiscourseReports
  class UserRecipesController < ::ApplicationController
    before_filter :ensure_logged_in

    def index
      params.permit(:offset, :limit)

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
        .where(user_id: user_id, topics: { archetype: 'recipe' })
        .order(created_at: :desc)
        .offset(offset)
        .limit(limit)
    end
  end
end
