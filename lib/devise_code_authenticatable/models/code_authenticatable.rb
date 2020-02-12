module Devise
  module Models
    module CodeAuthenticatable
      extend ActiveSupport::Concern

      included do
      end

      class_methods do
        def send_login_code(resource_params)
          resource = self.find_by(resource_params)
          if resource
            resource.resend_login_code
            resource
          else
            self.new(resource_params)
          end
        end

      end

      def resend_login_code
        code = login_code || regenerate_login_code
        send_devise_notification(:login_instructions, code, {})
      end

      def regenerate_login_code
        self.update(
          login_code: rand(10000..99999),
          login_code_retry_time: 0,
          login_code_created_at: Time.now
        )
        login_code
      end

      def login_code_expired?
        expire_in = 5.minute
        retry_time_limit = 5

        !(Time.now < self.login_code_created_at + expire_in && \
        self.login_code_retry_time.to_i < retry_time_limit)
      end

      def valid_login_code?(login_code)
        unless login_code_expired?
          self.update(login_code_retry_time: (self.login_code_retry_time.to_i + 1))
          self.login_code == login_code
        end
      end

      def after_code_authentication
      end

    end
  end
end
