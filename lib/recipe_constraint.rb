require_dependency 'current_user'

class RecipeConstraint
  def matches?(request)
    provider = Discourse.current_user_provider.new(request.env)
    provider.current_user && provider.current_user.trust_level >= SiteSetting.min_trust_to_edit_wiki_post.to_i
  end
end
