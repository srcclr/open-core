module DiscourseReports
  class PartSerializer < ApplicationSerializer
    attributes :id, :name, :position, :description
  end
end
