module DiscourseReports
  class Part < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    has_many :chapters, -> { order('discourse_reports_chapters.position') },
      foreign_key: :discourse_reports_part_id,
      dependent: :destroy

    acts_as_list

    def self.update_part_constraints
      SiteSetting.parts_constraint = self.all.pluck(:slug).join('|')
    end

    def name=(value)
      slug = (Slug.for(value.to_s).presence || 'part')
      write_attribute(:slug, slug)

      write_attribute(:name, value)
    end
  end
end
