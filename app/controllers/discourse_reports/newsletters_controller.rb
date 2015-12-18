module DiscourseReports
  class NewslettersController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      show_newsletter(newsletter)
    end

    def latest
      show_newsletter(Newsletter.latest)
    end

    def download
      send_data newsletter.pdf, type: "applicatiion/pdf", disposition: "attachment", filename: "#{newsletter.filename}.pdf"
    end

    def index
      render_json_dump(newsletters: serialize_data(newsletters, NewsletterArchiveSerializer),
                       latest_newsletter: serialize_data(latest_newsletter, NewsletterArchiveSerializer, root: false),
                       total_pages: total_pages)
    end

    private

    def show_newsletter(newsletter)
      serialized = serialize_data(newsletter, NewsletterSerializer, root: false)

      respond_to do |format|
        format.html do
          store_preloaded('newsletter',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

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
