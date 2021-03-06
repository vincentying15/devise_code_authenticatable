module Devise
  module Models
    module CodeAuthenticatable
      extend ActiveSupport::Concern

      included do
        has_many :login_codes, as: :resource
      end

      def login_code
        existing_login_code
      end

      def send_code_login_instructions
        login_code = existing_login_code || generate_login_code
        send_devise_notification(:code_login_instructions, login_code, {})
        self
      end

      def existing_login_code
        login_code = login_codes.last
        login_code && !login_code.expired? ? login_code.code : nil
      end

      def generate_login_code
        login_codes.create!.code
      end

      def after_code_authentication
        expire_all_login_codes
      end

      def expire_all_login_codes
        login_codes.each &:expire_now
      end

      module ClassMethods
        def send_code_login_instructions(attributes={})
          code_authenticatable = find_or_initialize_with_errors(send_login_token_keys, attributes, :not_found)
          code_authenticatable.send_code_login_instructions if code_authenticatable.persisted?
          code_authenticatable
        end
      end

    end
  end
end
