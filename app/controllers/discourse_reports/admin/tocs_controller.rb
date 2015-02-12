module DiscourseReports
  class Admin::TocsController < ::Admin::AdminController
    def show
      @parts = Part.all
      render json: @parts.to_json
    end
  end
end
