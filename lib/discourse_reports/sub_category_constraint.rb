module DiscourseReports
  class SubCategoryConstraint
    def matches?(request)
      !category_action?(request) && !subcategory?(request)
    end

    private

    def category_action?(request)
      request.params['slug'] === 'show'
    end

    def subcategory?(request)
      ::Category.joins(:parent_category).where(
        parent_categories_categories: { slug: request.params['category_slug'] },
        slug: request.params['slug']
      ).exists?
    end
  end
end
