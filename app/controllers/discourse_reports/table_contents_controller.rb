module DiscourseReports
  class TableContentsController < ::ApplicationController
    before_action :find_topic
    before_action :authorize_topic, only: :update

    def show
      if @topic
        render json: { url: @topic.url }
      else
        raise Discourse::NotFound
      end
    end

    def update
      chahgeTaxomnomiesPositions(Chapter.where('name ILIKE ?',  'taxonomy').first)

      toc = @topic.posts.first
      toc.raw = GenerateTableContent.new(parts).build_a_raw

      Post.transaction { (toc_sections << toc).each(&:save) }

      render nothing: true
    end

    private

    def chahgeTaxomnomiesPositions(chapter)
      return unless chapter

      topics = chapter.topics.reorder(:title).map.with_index do |section, index|
        section.tap { |section| section.position = index + 1 }
      end
      Topic.transaction { topics.each(&:save) }
    end

    def toc_sections
      sections.map.with_index do |topic, index|
        post = topic.posts.first
        previous_topic = sections.fetch(index - 1, nil) unless index.zero?
        next_topic = sections.fetch(index + 1, nil)

        GenerateNavigationLinks.new(post, previous_topic, next_topic).add_navigation
      end
    end

    def parts
      Part.order('position').includes(chapters: :topics)
    end

    def sections
      @sections ||= Topic.ordered_sections
    end

    def find_topic
      @topic = Topic.where(archetype: 'toc').first
    end

    def authorize_topic
      guardian.ensure_can_moderate!(@topic)
    end
  end
end
