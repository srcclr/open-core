PostRevisor.class_eval do
  track_topic_field(:chapter_id) do |tc, chapter_id|
    tc.record_change('chapter_id', tc.topic.chapter_id, chapter_id)
    tc.topic.chapter_id = chapter_id
  end
end
