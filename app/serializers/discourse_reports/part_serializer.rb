module DiscourseReports
  class PartSerializer < ApplicationSerializer
    attributes :id, :name, :slug, :position, :description, :pdf_text, :pdf_link, :has_link

    has_many :chapters, serializer: ChapterSerializer, embed: :objects

    def pdf_text
      pdf_text_array[object.position-1]
    end

    def pdf_link
      @pdf_link ||= pdf_urls_array[object.position-1]
    end

    def has_link
      pdf_link.to_s != "#"
    end

    private

    def pdf_text_array
      SiteSetting.settings_hash[:book_link_text].split("|")
    end

    def pdf_urls_array
      SiteSetting.settings_hash[:book_link_urls].split("|")
    end
  end
end
