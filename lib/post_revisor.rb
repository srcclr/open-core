PostRevisor.class_eval do
  track_topic_field(:chapter_id) do |tc, chapter_id|
    tc.record_change('chapter_id', tc.topic.chapter_id, chapter_id)
    tc.topic.chapter_id = chapter_id
  end

  track_topic_field(:position) do |tc, position|
    tc.record_change('position', tc.topic.position, position)
    tc.topic.position = position
  end
end
