module DiscourseReports
  class GenerateNavigationLinks
    def initialize(post, previous_topic, next_topic)
      @post = post
      @previous_topic = previous_topic
      @next_topic = next_topic
    end

    def add_navigation
      @post.tap do |post|
        post.raw = trim_post_raw_content(post) << navigation_block
      end
    end

    private

    def navigation_block
      return '' unless [@previous_topic, @next_topic].any?

      "\n\n[navigation]\n" \
      "#{navigation_link(@previous_topic, 'prev')}" \
      "#{navigation_link(@next_topic, 'next')}" \
      "[/navigation]"
    end

    def trim_post_raw_content(post)
      post.raw.partition("[navigation]")[0].rstrip
    end

    def navigation_link(topic, direction)
      return '' unless topic

      "[#{direction}][#{topic.title}](#{link_to_topic(topic)})[/#{direction}]\n"
    end

    def link_to_topic(topic)
      "/#{topic.part_slug}/#{topic.chapter_slug}/#{topic.slug}"
    end
  end
end
