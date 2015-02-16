module DiscourseReports
  class Part < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true

    acts_as_list

    def name=(value)
      slug = (Slug.for(value.to_s).presence || 'part')
      write_attribute(:slug, slug)

      write_attribute(:name, value)
    end
  end
end
