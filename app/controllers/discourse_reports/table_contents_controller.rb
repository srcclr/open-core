module DiscourseReports
  class TableContentsController < ::ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required
    before_action :authorize_topic, only: :update

    def show
      return raise Discourse::NotFound if part.blank?

      respond_to do |format|
        format.html { render 'default/empty' }
        format.json { render_json_dump(serialized_part) }
      end
    end

    def index
      if topic
        serialized = serialize_data(parts, PartSerializer)

        respond_to do |format|
          format.html do
            store_preloaded('guides',  MultiJson.dump(serialized))
            render 'default/empty'
          end
          format.json { render_json_dump(serialized) }
        end
      else
        raise Discourse::NotFound
      end
    end

    def update
      chahgeTaxomnomiesPositions(Chapter.where('name ILIKE ?',  'taxonomy').first)

      toc = topic.posts.first
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

    def topic
      @topic ||= Topic.where(archetype: 'toc').first
    end

    def part
      @part ||= Part.find_by_slug(params[:slug])
    end

    def serialized_part
      serialize_data(part, PartSerializer)
    end

    def authorize_topic
      guardian.ensure_can_moderate!(topic)
    end
  end
end
