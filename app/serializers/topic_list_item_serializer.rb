TopicListItemSerializer.class_eval do
  attributes :tags
  has_one :category, serializer: BasicCategorySerializer
  has_one :user, serializer: BasicUserSerializer, embed: :object

  def tags
    object.try(:tags) || []
  end
end
