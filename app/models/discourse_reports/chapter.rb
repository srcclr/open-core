module DiscourseReports
  class Chapter < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true

    belongs_to :part, foreign_key: :discourse_reports_part_id

    acts_as_list scope: :discourse_reports_part_id

    def name=(value)
      slug = (Slug.for(value.to_s).presence || 'chapter')
      write_attribute(:slug, slug)

      write_attribute(:name, value)
    end
  end
end
