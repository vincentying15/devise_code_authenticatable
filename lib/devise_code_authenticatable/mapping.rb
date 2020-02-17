module DeviseCodeAuthenticatable
  module Mapping
    private

      def default_controllers(options)
        options[:controllers] ||= {}
        options[:controllers][:sessions] ||= 'devise_code_authenticatable/sessions'
        super
      end
  end
end
