module DeviseCodeAuthenticatable
  autoload :LoginCode, 'devise_code_authenticatable/login_code'
  autoload :Mailer, 'devise_code_authenticatable/mailer'
  autoload :Mapping, 'devise_code_authenticatable/mapping'
  autoload :ParameterSanitizer, 'devise_code_authenticatable/parameter_sanitizer'
  module Controllers
    autoload :Sessions, 'devise_code_authenticatable/controllers/sessions'
    autoload :Helpers, 'devise_code_authenticatable/controllers/helpers'
  end
end


require 'devise'
require 'devise_code_authenticatable/routes'
require 'devise_code_authenticatable/rails'
require 'devise_code_authenticatable/strategies/code_authenticatable'

module Devise
end



Devise.add_module :code_authenticatable,
  strategy: true,
  model: 'devise_code_authenticatable/models',
  route: { login_code: [nil, :show, :resend, :verify] }
