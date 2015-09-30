module DiscourseReports
  class NewsletterArchiveSerializer < ApplicationSerializer
    attributes :id, :title, :url

    def url
      object.topic_links.try(:first).try(:url)
    end
  end
end
