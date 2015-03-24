module DiscourseReports
  class TopicRecipeSerializer < ActiveModel::Serializer
    attributes :id, :post, :title, :url, :category, :categories, :tags

    delegate :category_id, to: :object

    alias_method :category, :category_id

    private

    def tags
      object.respond_to?(:tags) ? object.tags : []
    end

    def post
      object.posts.first.as_json(only: %w(raw id))
    end

    def categories
      recipe = Category.find_by(name: 'Recipes')
      (recipe && recipe.subcategories) || []
    end
  end
end
