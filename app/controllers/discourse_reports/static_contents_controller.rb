module DiscourseReports
  class StaticContentsController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      allowed_types = ['login_help']
      content = params[:id]

      if allowed_types.include?(content)
        data = PrettyText.cook(SiteText.text_for(content.to_sym))

        render_json_dump(data)
      else
        render json: failed_json
      end
    end
  end
end
