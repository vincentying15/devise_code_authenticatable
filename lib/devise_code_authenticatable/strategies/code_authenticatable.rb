require 'devise/strategies/base'

module DeviseCodeAuthenticatable
  module Strategies
    class CodeAuthenticatable < Devise::Strategies::Authenticatable

      def authenticate!
        resource = mapping.to.find_for_authentication(authentication_hash)
        hashed = false
        login_code = params[scope].fetch "login_code", ""

        if resource.existing_login_code.expired?
          fail(:login_code_expired)
          resource.send_login_code
          respond_with(resource, location: after_sending_login_code_path_for(resource))
        end

        if validate(resource){ hashed = true; resource.existing_login_code.verify(login_code) }
          remember_me(resource)
          cookies[:devise_resource_email] = resource.email
          resource.after_code_authentication
          success!(resource)
        else
          fail(:invalid_login_code)
        end
      end

    end
  end
end

Warden::Strategies.add :code_authenticatable, DeviseCodeAuthenticatable::Strategies::CodeAuthenticatable
