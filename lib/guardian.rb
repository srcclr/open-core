Guardian.class_eval do
  define_method("can_see_topic_with_publicity?") do |topic|
    [SiteSetting.guidelines_topic_id].include?(topic.id) ||
      can_see_topic_without_publicity?(topic)
  end
  alias_method_chain :can_see_topic?, :publicity
end
