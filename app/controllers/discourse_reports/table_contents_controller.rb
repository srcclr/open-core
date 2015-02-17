module DiscourseReports
  class TableContentsController < ::ApplicationController
    before_action :find_and_authorize_topic

    def update
      post = @topic.posts.first
      post.update_attributes!(raw: GenerateTableContent.new(parts).build_a_raw)

      render nothing: true
    end

    private

    def parts
      Part.includes(chapters: :topics)
    end

    def find_and_authorize_topic
      @topic = Topic.where(archetype: 'toc').find(params[:id].to_i)
      guardian.ensure_can_moderate!(@topic)
    end
  end
end
