CurrentUserSerializer.class_eval do
  attributes :can_create_howto, :can_create_blog, :can_see_howtos, :can_see_blogs

  def can_invite_to_forum
    object.trust_level >= SiteSetting.min_invite_trust_level.to_i
  end

  def can_create_howto
    scope.can_create_topic_on_category?(find_category('How-Tos')) &&
      object.trust_level >= SiteSetting.min_trust_to_edit_wiki_post.to_i
  end

  def can_create_blog
    scope.can_create_topic_on_category?(find_category('Blogs'))
  end

  def can_see_howtos
    can_see('How-Tos')
  end

  def can_see_blogs
    can_see('Blogs')
  end

  private

  def can_see(category_name)
    public_send("can_create_#{category_slug(category_name)}") ||
      Category.where(id: object.topics.pluck(:category_id)).include?(find_category(category_name))
  end

  def find_category(name)
    Category.find_by(name: name)
  end

  def category_slug(name)
    name.gsub(/\W/, '').downcase.singularize
  end
end
