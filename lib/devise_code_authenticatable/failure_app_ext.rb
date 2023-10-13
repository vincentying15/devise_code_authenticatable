module DeviseCodeAuthenticatable
  module FailureAppExt
    def redirect_url
      if warden_message == :invalid_login_code
        request.referrer || super
      else
        super
      end
    end
  end
end