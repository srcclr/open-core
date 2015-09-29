require 'ostruct'

module DiscourseReports
  TOPICS_TAGS = {
    SiteSetting.tag_topic_needs_more_content => 'incomplete',
    SiteSetting.tag_topic_needs_a_lot_of_content => 'started-topic'
  }

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

      "##**Part #{part.position}**. #{part.name} [expandable-icon-square][/expandable-icon-square]" \
      "[part]\n#{part.description}\n\n#{chapters.join}\n[/part]"
    end

    def build_a_chapter(chapter)
      topics =
        if chapter.topics.any?
          chapter.topics.without_subsections.map.with_index do |topic, index|
            position = chapter.topics.first.position.zero? ? index : index + 1
            build_a_topic(topic, position)
          end
        else
          []
        end

      "[sections]" \
      "[[num]**#{chapter.part_position + INCREMENT}.#{chapter.position + INCREMENT}**.00[/num]" \
      "**#{chapter.name}**[expandable-icon-circle][/expandable-icon-circle]](#{link_to_topic(chapter.topics.first || NULL_TOPIC)})" \
      "[section]#{topics.join("")}[/section][/sections]"
    end

    def build_a_topic(topic, index)
      return '' if topic.position.zero?

      subsections = topic.subsections.map do |subsection|
        build_a_subsection(subsection)
      end

      raw = "[[num]#{topic.part_position + INCREMENT}.#{topic.chapter_position + INCREMENT}." \
            "**#{(INCREMENT + index).to_s.rjust(2, '0')}**[/num]"

      raw << if completion_tag = completion_tag_bbcode(topic)
        "[#{completion_tag}]#{topic.title}[/#{completion_tag}]](#{link_to_topic(topic)})"
      else
        "#{topic.title}](#{link_to_topic(topic)})"
      end

      raw.tap { |raw| raw << "<ul>#{subsections.join("")}</ul>" if subsections.any? }
    end

    def build_a_subsection(subsection)
      "<li>[#{subsection.title}](#{link_to_topic(subsection)})</li>"
    end

    def link_to_topic(topic)
      "/#{topic.part_slug}/#{topic.chapter_slug}/#{topic.slug}"
    end

    def completion_tag_bbcode(topic)
      tags = ((topic.respond_to?(:tags) && topic.tags) || [])
      tag = (TOPICS_TAGS.keys & tags)[0]

      TOPICS_TAGS[tag]
    end
  end
end
