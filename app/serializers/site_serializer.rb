SiteSerializer.class_eval do
  attributes :chapters

  private

  def chapters
    DiscourseReports::Chapter.order('position')
      .select(:id, :name)
      .as_json
  end
end
