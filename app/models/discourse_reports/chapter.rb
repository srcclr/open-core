module DiscourseReports
  class Chapter < ActiveRecord::Base
    extend Forwardable

    validates :name, presence: true, uniqueness: true

    belongs_to :part, foreign_key: :discourse_reports_part_id
    has_many :topics, -> { order('topics.position') }

    acts_as_list scope: :discourse_reports_part_id

    def_delegator :part, :position, :part_position

    def name=(value)
      slug = (Slug.for(value.to_s).presence || 'chapter')
      write_attribute(:slug, slug)

      write_attribute(:name, value)
    end
  end
end
