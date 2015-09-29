module DiscourseReports
  class PartSerializer < ApplicationSerializer
    attributes :id, :name, :position, :description, :pdf_text, :pdf_link

    has_many :chapters, serializer: ChapterSerializer, embed: :objects

    def pdf_text
      SiteSetting.settings_hash["book_link_text_#{object.position}".to_sym]
    end

    def pdf_link
      SiteSetting.settings_hash["book_link_url_#{object.position}".to_sym]
    end
  end
end
