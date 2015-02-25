module DiscourseReports
  class TableContentsController < ::ApplicationController
    before_action :find_topic
    before_action :authorize_topic, only: :update

    def show
      if @topic
        redirect_to @topic.relative_url
      else
        raise Discourse::NotFound
      end
    end

    def update
      post = @topic.posts.first
      post.update_attributes!(raw: GenerateTableContent.new(parts).build_a_raw)

      render nothing: true
    end

    private

    def parts
      Part.order('position').includes(chapters: :topics)
    end

    def find_topic
      @topic = Topic.where(archetype: 'toc').first
    end

    def authorize_topic
      guardian.ensure_can_moderate!(@topic)
    end
  end
end
