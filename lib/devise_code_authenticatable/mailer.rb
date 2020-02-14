module DeviseCodeAuthenticatable
  module Mailer

    # deliver a mail containing login code
    def code_login_instructions(record, code, opts = {})
      @code = code
      devise_mail(record, :login_code, opts)
    end
  end
end
