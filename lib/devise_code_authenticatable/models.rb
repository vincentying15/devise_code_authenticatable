require 'active_support/deprecation'
require 'devise_code_authenticatable/models/code_authenticatable'

module Devise
  module Models
    module CodeAuthenticatable
      extend ActiveSupport::Concern


      module ClassMethods
        def send_login_token_keys
          [:email]
        end
      end

    end
  end
end
