PostRevisor.class_eval do
  track_topic_field(:chapter_id) do |tc, chapter_id|
    tc.record_change('chapter_id', tc.topic.chapter_id, chapter_id)
    tc.topic.chapter_id = chapter_id
  end

  track_topic_field(:parent_topic_id) do |tc, parent_topic_id|
    tc.record_change('parent_topic_id', tc.topic.parent_topic_id, parent_topic_id)
    tc.topic.parent_topic_id = parent_topic_id
  end

  track_topic_field(:archetype) do |tc, archetype|
    tc.record_change('archetype', tc.topic.archetype, archetype)
    tc.topic.archetype = archetype
  end

  track_topic_field(:position) do |tc, position|
    tc.record_change('position', tc.topic.position, position)
    tc.topic.position = position
  end
end
