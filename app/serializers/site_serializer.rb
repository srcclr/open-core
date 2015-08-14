SiteSerializer.class_eval do
  attributes :chapters, :uncategorized_category_slug

  private

  def uncategorized_category_slug
    SiteSetting.uncategorized_category_slug
  end

  def chapters
    DiscourseReports::Chapter.order('position')
      .select(:id, :name)
      .as_json
  end
end
