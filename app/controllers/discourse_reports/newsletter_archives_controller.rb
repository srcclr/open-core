module DiscourseReports
  class NewsletterArchivesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      send_file newsletter_html_link, layout: false, disposition: "inline"
    end

    def download
      send_file newsletter_html_link, disposition: "attachment"
    end

    def index
      render json: serialize_data(newsletter_archives, NewsletterArchiveSerializer), root: "newsletters"
    end

    private

    def newsletter_html_link
      if newsletter.present?
        File.join(Rails.root, "public", newsletter.topic_links.first.try(:url))
      else
        "#"
      end
    end

    def newsletter
      @newsletter ||= newsletter_archives.find_by_id!(params[:id])
    end

    def newsletter_archives
      @newsletter_archives ||= Topic.joins(:topic_links).joins(:category)
        .where(categories: { slug: 'newsletters' })
        .order(created_at: :desc)
    end
  end
end
