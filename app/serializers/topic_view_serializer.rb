TopicViewSerializer.class_eval do
  attributes_from_topic :chapter_id, :position

  has_one :user, serializer: DiscourseReports::ExtendedUserSerializer, embed: :object

  def user
    object.topic.user if object.topic.archetype.eql?('blog')
  end
end
