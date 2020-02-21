module DeviseCodeAuthenticatable
  module Mailer
    extend ActiveSupport::Concern

    included do
      default from: ENV["DEVISE_MAILER_SENDER"]
    end

    # deliver a mail containing login code
    def code_login_instructions(record, code, opts = {})
      @code = code
      opts[:subject] = "#{@code} is your login code"
      devise_mail(record, :login_code, opts)
    end
  end
end
