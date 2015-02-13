require 'ostruct'

module DiscourseReports
  class GenerateTableContent
    INCREMENT = 0
    NULL_TOPIC = OpenStruct.new(part_slug: '', chapter_slug: '', slug: '')

    def initialize(parts)
      @parts = parts
    end

    def build_a_raw
      @parts.map { |part| build_a_part(part) }.join("\n")
    end

    private

    def build_a_part(part)
      chapters = part.chapters.map do |chapter|
        build_a_chapter(chapter)
      end

      "##Part #{part.position}. #{part.name} \n#{part.description}\n\n" << chapters.join("\n")
    end

    def build_a_chapter(chapter)
      topics = chapter.topics.map do |topic|
        build_a_topic(topic)
      end

      "**#{chapter.part_position + INCREMENT}.#{chapter.position + INCREMENT}**.00&nbsp;&nbsp;&nbsp;" \
        "[**#{chapter.name}**](#{link_to_topic(chapter.topics.first || NULL_TOPIC)})\n" << topics.join("\n")
    end

    def build_a_topic(topic)
      "#{topic.part_position + INCREMENT}.#{topic.chapter_position + INCREMENT}." \
        "**#{(INCREMENT + topic.position).to_s.rjust(2, '0')}**" \
        "&nbsp;&nbsp;&nbsp;[#{topic.title}](#{link_to_topic(topic)})"
    end

    def link_to_topic(topic)
      "/#{topic.part_slug}/#{topic.chapter_slug}/#{topic.slug}"
    end
  end
end
