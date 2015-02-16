module DiscourseReports
  class Part < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    has_many :chapters, -> { order('discourse_reports_chapters.position') },
      foreign_key: :discourse_reports_part_id

    acts_as_list

    def name=(value)
      slug = (Slug.for(value.to_s).presence || 'part')
      write_attribute(:slug, slug)

      write_attribute(:name, value)
    end
  end
end
