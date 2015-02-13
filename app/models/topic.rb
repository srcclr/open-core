Topic.class_eval do
  acts_as_list scope: :chapter_id
  belongs_to :chapter, class_name: 'DiscourseReports::Chapter'
end
