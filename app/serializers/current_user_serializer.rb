CurrentUserSerializer.class_eval do
  def can_invite_to_forum
    object.trust_level >= SiteSetting.min_invite_trust_level.to_i
  end
end
