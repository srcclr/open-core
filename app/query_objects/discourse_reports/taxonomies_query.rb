module DiscourseReports
  class TaxonomiesQuery
    def initialize(params)
      @params = params
    end

    def taxonomies
      PaginatedQuery.new(filtered_topics, @params).list
    end

    def available_letters
      Topic.joins(:category).where(categories: { slug: 'taxonomy' })
           .pluck('DISTINCT(upper(LEFT(title, 1)))')
    end

    private

    def filtered_topics
      if @params[:letter].present?
        @topics = topics.where("topics.title ILIKE ?", "#{@params[:letter]}%")
      end

      topics
    end

    def topics
      @topics ||= Topic.includes(:category, :user, :_custom_fields)
        .where(categories: { slug: 'taxonomy' })
        .order(:title)
    end
  end
end
