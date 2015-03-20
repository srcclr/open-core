module DiscourseReports
  class RecipeSubcategoriesController < ApplicationController
    skip_before_filter :check_xhr, :redirect_to_login_if_required

    def index
      serialized = serialize_data(subcategories, BasicCategorySerializer)

      respond_to do |format|
        format.html do
          store_preloaded('recipe_subcategories',  MultiJson.dump(serialized))
          render 'default/empty'
        end

        format.json { render_json_dump(serialized) }
      end
    end

    private

    def subcategories
      recipe = Category.find_by(name: 'Recipes')

      (recipe && recipe.subcategories) || []
    end
  end
end
