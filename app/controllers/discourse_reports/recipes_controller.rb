module DiscourseReports
  class RecipesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      serialized = serialize_data(topics, TopicListItemSerializer)

      respond_to do |format|
        format.html do
          store_preloaded('recipes_topics',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    def new
      render 'default/empty'
    end

    def edit
      serialized = serialize_data(topic, TopicRecipeSerializer, root: false)

      respond_to do |format|
        format.html do
          store_preloaded("recipe_#{topic.id}",  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def topic
      @post ||= topics.includes(:posts).find(params[:id])
    end

    def topics
      Topic
        .includes(:category, :user, :_custom_fields)
        .where(archetype: 'recipe')
    end
  end
end
