module DeviseCodeAuthenticatable
  autoload :LoginCode, 'devise_code_authenticatable/login_code'
  autoload :Mailer, 'devise_code_authenticatable/mailer'
  autoload :Mapping, 'devise_code_authenticatable/mapping'
  autoload :ParameterSanitizer, 'devise_code_authenticatable/parameter_sanitizer'
  autoload :FailureAppExt, 'devise_code_authenticatable/failure_app_ext'
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
  # Public: Maximum retry times for a code to be verifed (default: 5).
  # Login code will not change even if user click resend mail,
  # and the same code will be sent again.
  #
  #   config.retry_limit = 1 # => The code will be reset immediately when user passed wrong code
  mattr_accessor :retry_limit
  @@retry_limit = 5

  # Public: Deadline for a code to be verifed (default: 10.minutes).
  # Login code will expired if user has not enter the login_code in 10 minutes
  #
  #   config.expire_time = 1.hour # => The code is valid in the next hour after generated
  mattr_accessor :expire_time
  @@expire_time = 10.minutes
end



Devise.add_module :code_authenticatable,
  strategy: true,
  model: 'devise_code_authenticatable/models',
  route: { login_code: [nil, :show, :resend, :verify] }
