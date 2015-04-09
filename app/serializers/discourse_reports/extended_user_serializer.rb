module DiscourseReports
  class ExtendedUserSerializer < BasicUserSerializer
    attributes :company

    def company
      object.user_fields['1']
    end
  end
end
