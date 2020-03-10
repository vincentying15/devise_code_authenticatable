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

        Devise::Models.config(self, :retry_limit)
        Devise::Models.config(self, :expire_time)
      end

    end
  end
end
