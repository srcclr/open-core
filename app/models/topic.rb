Topic.class_eval do
  if column_names.include? 'position'
    acts_as_list top_of_list: 0, scope: :chapter_id
  end

  belongs_to :chapter, class_name: 'DiscourseReports::Chapter'
  belongs_to :parent_topic, class_name: 'Topic'
  belongs_to :category

  has_one :part, through: :chapter, class_name: 'DiscourseReports::Part'
  has_many :subsections, class_name: 'Topic', foreign_key: :parent_topic_id
  has_many :topic_links

  scope :ordered_sections, -> do
    joins(chapter: :part)
      .includes(chapter: :part)
      .order(
        'discourse_reports_parts.position',
        'discourse_reports_chapters.position',
        'topics.position'
      )
  end

  scope :without_subsections, -> { where('parent_topic_id IS ?', nil) }

  def_delegator :part, :position, :part_position
  def_delegator :part, :slug, :part_slug
  def_delegator :chapter, :position, :chapter_position
  def_delegator :chapter, :slug, :chapter_slug
end
