UserNotifications.class_eval do
  def forgot_password(user, opts={})
    email_type = user.has_password? ? 'forgot_password' : 'set_password'

    body = SiteText.text_for(email_type.to_sym,
                              base_url: Discourse.base_url,
                              email_token: opts[:email_token])

    build_email(user.email, body: body)
  end
end
