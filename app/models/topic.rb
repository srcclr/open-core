Topic.class_eval do
  acts_as_list scope: :chapter_id
end
