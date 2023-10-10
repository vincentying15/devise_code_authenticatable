require 'devise/strategies/base'

module DeviseCodeAuthenticatable
  module Strategies
    class CodeAuthenticatable < Devise::Strategies::Authenticatable

      def authenticate!
        resource = mapping.to.find_for_authentication(authentication_hash)
        hashed = false
        login_code = params[scope].fetch "login_code", ""

        if resource.nil?
          fail(:not_found_in_database); return
        end

        if resource.login_codes.empty?
          fail(:login_code_expired); return
        end

        if resource.login_codes.last.expired?
          resource.expire_all_login_codes
          fail(:login_code_expired); return
        end

        if validate(resource){ hashed = true; resource.login_codes.last.verify(login_code) }
          remember_me(resource)
          yield resource if block_given?
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
