require_dependency 'email/sender'

module Jobs
  class RequestEmail < Jobs::Base
    def execute(args)
      raise Discourse::InvalidParameters.new(:email) unless args[:email].present?
      message = RequestMailer.send_request(args)
      Email::Sender.new(message, :request_message).send
    end
  end
end
