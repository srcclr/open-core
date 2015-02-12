module DiscourseReports
  class RecipesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      serialized = serialize_data(topics, TopicHomepageSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('recipes_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def topics
      Topic
        .includes(:category)
        .where(archetype: 'recipe')
    end
  end
end
