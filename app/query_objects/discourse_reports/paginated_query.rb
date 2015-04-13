module DiscourseReports
  class PaginatedQuery
    def initialize(collection, params)
      @collection = collection
      @params = params
    end

    def list
      offset = [@params[:offset].to_i, 0].max
      limit = [(@params[:limit] || 10).to_i, 100].min

      @collection.limit(limit).offset(offset)
    end
  end
end
