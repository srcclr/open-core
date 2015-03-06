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
end
