Topic.class_eval do
  acts_as_list top_of_list: 0, scope: :chapter_id
  belongs_to :chapter, class_name: 'DiscourseReports::Chapter'
  has_one :part, through: :chapter, class_name: 'DiscourseReports::Part'

  def_delegator :part, :position, :part_position
  def_delegator :part, :slug, :part_slug
  def_delegator :chapter, :position, :chapter_position
  def_delegator :chapter, :slug, :chapter_slug
end
