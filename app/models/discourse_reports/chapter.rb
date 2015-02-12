module DiscourseReports
  class Chapter < ActiveRecord::Base
    def name=(value)
      slug = (Slug.for(value.to_s).presence || 'chapter')
      write_attribute(:slug, slug)

      write_attribute(:name, value)
    end
  end
end
