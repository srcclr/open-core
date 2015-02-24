module DiscourseReports
  class CommunityRequestsController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def create
      Jobs.enqueue(:request_email, community_request_params)
      render nothing: true
    end

    private

    def community_request_params
      params.require(:fields).permit(:country, :city, :meetup_id, :email, :request_text)
    end
  end
end
