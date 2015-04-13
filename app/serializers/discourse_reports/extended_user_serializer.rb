module DiscourseReports
  class ExtendedUserSerializer < BasicUserSerializer
    attributes :company

    def company
      object.user_fields[UserField.find_by(name: 'Company').id.to_s]
    end
  end
end
