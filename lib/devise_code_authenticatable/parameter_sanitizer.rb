module DeviseCodeAuthenticatable
  module ParameterSanitizer
    if defined?(Devise::BaseSanitizer)
      def sign_in
        permit self.for(:sign_in)
      end
    end

    private

      if defined?(Devise::BaseSanitizer)
        def permit(keys)
          default_params.permit(*Array(keys))
        end

        def attributes_for(kind)
          case kind
          when :sign_in
            [:email, :login_code]
          else
            super
          end
        end
      else
        def initialize(resource_class, resource_name, params)
          super
          permit(:login_code, keys: [:email, :login_code] )
        end
      end
  end
end
