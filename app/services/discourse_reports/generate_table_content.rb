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

      "##Part #{part.position}. #{part.name} \n#{part.description}\n\n" \
      "[part]\n#{chapters.join}\n[/part]"
    end

    def build_a_chapter(chapter)
      topics = chapter.topics.without_subsections.map.with_index do |topic, index|
        build_a_topic(topic, index + 1)
      end

      "[sections]\n" \
      "[[num]**#{chapter.part_position + INCREMENT}.#{chapter.position + INCREMENT}**.00[/num]" \
      "**#{chapter.name}**](#{link_to_topic(chapter.topics.first || NULL_TOPIC)})#{topics.join("\n")}" \
      "\n[/sections]"
    end

    def build_a_topic(topic, index)
      return '' if topic.position.zero?

      subsections = topic.subsections.map do |subsection|
        build_a_subsection(subsection)
      end

      "[[num]#{topic.part_position + INCREMENT}.#{topic.chapter_position + INCREMENT}." \
      "**#{(INCREMENT + index).to_s.rjust(2, '0')}**[/num]#{topic.title}](#{link_to_topic(topic)})" \
      "<ul>#{subsections.join("\n")}</ul>"
    end

    def build_a_subsection(subsection)
      "<li>[#{subsection.title}](#{link_to_topic(subsection)})</li>"
    end

    def link_to_topic(topic)
      "/#{topic.part_slug}/#{topic.chapter_slug}/#{topic.slug}"
    end
  end
end
