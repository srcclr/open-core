module DiscourseReports
  class ExtendedUserSerializer < BasicUserSerializer
    attributes :company

    has_many :additional_blogs, serializer: BasicTopicSerializer, embed: :objects

    def company
      object.user_fields[UserField.find_by(name: 'Company').id.to_s]
    end

    def additional_blogs
      object.topics.by_newest.where(archetype: 'blog').first(5)
    end
  end
end
