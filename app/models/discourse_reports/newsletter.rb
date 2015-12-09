module DiscourseReports
  class Newsletter
    def self.all
      Topic.joins(:topic_links).joins(:category)
        .where(categories: { slug: "newsletters" })
        .order(created_at: :desc)
    end

    def self.find(id)
      self.new(all.find_by_id!(id))
    end

    def initialize(newsletter_topic)
      @newsletter_topic ||= newsletter_topic
    end

    def html
      return "#" if @newsletter_topic.blank?

      File.join(Rails.root, "public", @newsletter_topic.topic_links.first.try(:url))
    end

    def pdf
      kit = PDFKit.new(File.new(html))
      kit.to_pdf
    end

    def img
      kit = IMGKit.new(File.new(html), :quality => 50)
      kit.to_img
    end 
    
    def filename
      @newsletter_topic.excerpt.split(".").first
    end
  end
end
