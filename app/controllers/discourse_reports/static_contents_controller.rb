module DiscourseReports
  class StaticContentsController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      allowed_types = %i(login_help login_page_text request_community_page_text)
      content = params[:id]

      if allowed_types.include?(content.to_sym)
        data = PrettyText.cook(SiteText.text_for(content))

        render_json_dump(data)
      else
        render json: failed_json
      end
    end
  end
end
