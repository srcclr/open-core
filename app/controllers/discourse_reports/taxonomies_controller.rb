module DiscourseReports
  class TaxonomiesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      params.permit(:offset, :limit, :letter)

      serialized = serialize_data(topics, BlogSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('taxonomies_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def topics
      TaxonomiesQuery.new(params).list
    end
  end
end
