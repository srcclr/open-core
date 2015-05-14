Guardian.class_eval do
  define_method("can_see_topic?") do |topic|
    [SiteSetting.guidelines_topic_id].include? topic.id
  end
end
