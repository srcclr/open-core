CurrentUserSerializer.class_eval do
  attributes :can_create_recipe

  def can_invite_to_forum
    object.trust_level >= SiteSetting.min_invite_trust_level.to_i
  end

  def can_create_recipe
    object.trust_level >= SiteSetting.min_trust_to_edit_wiki_post.to_i
  end
end
