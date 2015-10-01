module DiscourseReports
  class NewsletterArchivesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def show
      redirect_to newsletter_html_link
    end

    def index
      render json: serialize_data(newsletter_archives, NewsletterArchiveSerializer), root: 'newsletters'
    end

    private

    def newsletter_html_link
      newsletter = newsletter_archives.find_by_id!(params[:id])
      newsletter.present? ? newsletter.topic_links.first.try(:url) : "#"
    end

    def newsletter_archives
      @newsletter_archives ||= Topic.joins(:topic_links).joins(:category)
        .where(categories: { slug: 'newsletters' })
        .order(created_at: :desc)
    end
  end
end
