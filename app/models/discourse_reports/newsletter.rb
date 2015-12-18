module DiscourseReports
  class Newsletter
    include ActiveModel::Serialization

    attr_reader :newsletter_topic

    delegate :title, to: :newsletter_topic

    def self.all
      Topic.joins(:topic_links).joins(:category)
        .where(categories: { slug: "newsletters" })
        .order(created_at: :desc)
    end

    def self.find(id)
      self.new(all.find_by_id!(id))
    end

    def self.latest
      self.new(all.first)
    end

    def initialize(newsletter_topic)
      @newsletter_topic ||= newsletter_topic
    end

    def html
      @newsletter_topic.blank? ? "#" : file
    end

    def body
      Nokogiri::HTML(File.read(file)).css("body").to_s
    end

    def file
      File.join(Rails.root, "public", @newsletter_topic.topic_links.first.try(:url))
    end

    def pdf
      kit = PDFKit.new(File.new(html))
      kit.to_pdf
    end

    def filename
      @newsletter_topic.excerpt.split(".").first
    end
  end
end
