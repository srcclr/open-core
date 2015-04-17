TopicViewSerializer.class_eval do
  attributes_from_topic :chapter_id, :position

  has_one :user, serializer: DiscourseReports::ExtendedUserSerializer, embed: :object
  has_many :additional_topics_by_user, serializer: BasicTopicSerializer, embed: :objects

  private

  def archetype
    object.topic.archetype
  end

  def user
    object.topic.user
  end

  def additional_topics_by_user
    user.topics.where(archetype: archetype).order('RANDOM()').first(5)
  end
end
