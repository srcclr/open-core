module DiscourseReports
  class NewslettersController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      send_file newsletter.html, layout: false, disposition: "inline"
    end

    def download
      send_file newsletter.pdf, disposition: "attachment"
    end

    def index
      render json: serialize_data(Newsletter.all, NewsletterArchiveSerializer), root: "newsletters"
    end

    private

    def newsletter
      @newsletter ||= Newsletter.find(params[:id])
    end
  end
end
