InviteMailer.class_eval do
  def send_invite(invite)
    invitee_name = invite.invited_by.username
    if SiteSetting.enable_names && invite.invited_by.name.present?
      invitee_name = "#{invite.invited_by.name} (#{invite.invited_by.username})"
    end

    body = SiteText.text_for(:invite_email,
                              invitee_name: invitee_name,
                              site_domain_name: Discourse.current_hostname,
                              invite_link: "#{Discourse.base_url}/invites/#{invite.invite_key}",
                              site_description: SiteSetting.site_description,
                              site_title: SiteSetting.title)

    build_email(invite.email, body: body)
  end

  def send_password_instructions(user)
    if user.present?
      email_token = user.email_tokens.create(email: user.email)
      body = SiteText.text_for(:invite_password_instructions,
                                base_url: Discourse.base_url,
                                email_token: email_token.token)

      build_email(user.email, body: body)
    end
  end
end
