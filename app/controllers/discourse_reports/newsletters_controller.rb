module DiscourseReports
  class NewslettersController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      send_file newsletter.html, layout: false, disposition: "inline"
    end

    def download
      send_data newsletter.pdf, type: "applicatiion/pdf", disposition: "attachment", filename: "#{newsletter.filename}.pdf"
    end

    def index
      render_json_dump(newsletters: serialize_data(newsletters, NewsletterArchiveSerializer),
                       latest_newsletter: serialize_data(latest_newsletter, NewsletterArchiveSerializer, root: false),
                       total_pages: total_pages)
    end

    def latest
      send_data Newsletter.new(latest_newsletter).img, type: "image/jpg", disposition: "inline"
    end

    private

    def page
      params[:page].to_i
    end

    def total_pages
      Newsletter.all.count / 10
    end

    def newsletters
      Newsletter.all.offset(page * 10).limit(10)
    end

    def latest_newsletter
      Newsletter.all.first
    end

    def newsletter
      @newsletter ||= Newsletter.find(params[:id])
    end
  end
end
