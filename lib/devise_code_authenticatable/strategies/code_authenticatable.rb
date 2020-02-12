require 'devise/strategies/base'

module DeviseCodeAuthenticatable
  module Strategies

    class CodeAuthenticatable < Devise::Strategies::Authenticatable
      def authenticate!
        resource = mapping.to.find_for_authentication(authentication_hash)
        hashed = false
        login_code = params[scope].fetch "login_code", ""

        if resource
          if resource.login_code_expired?
            fail(:login_code_expired)
            resource.regenerate_login_code
            resource.resend_login_code
          else
            if validate(resource){ hashed = true; resource.valid_login_code?(login_code) }
              remember_me(resource)
              resource.after_code_authentication
              success!(resource)
            else
              fail(:invalid_login_code)
            end
          end
        else
          fail(:not_found_in_database)
        end
      end
    end
  end
end

Warden::Strategies.add :code_authenticatable, DeviseCodeAuthenticatable::Strategies::CodeAuthenticatable
