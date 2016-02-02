module DiscourseReports
  class SitemapsController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      render text: "Holy!"
    end
  end
end
