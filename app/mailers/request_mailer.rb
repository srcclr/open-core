require_dependency 'email/message_builder'

class RequestMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def send_request(args)
    build_email(SiteSetting.contact_email,
                template: 'request_mailer',
                country: args[:country],
                city: args[:city],
                meetup_id: args[:meetup_id],
                email: args[:email],
                request_text: args[:request_text])
  end
end
