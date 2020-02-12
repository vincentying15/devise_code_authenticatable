module DeviseCodeAuthenticatable
  autoload :Mailer, 'devise_code_authenticatable/mailer'
  autoload :Mapping, 'devise_code_authenticatable/mapping'

  module Controllers
    autoload :Helpers, 'devise_code_authenticatable/controllers/helpers'
    autoload :Sessions, 'devise_code_authenticatable/controllers/sessions'
  end
end


require 'devise'
require 'devise_code_authenticatable/strategies/code_authenticatable'
require 'devise_code_authenticatable/rails'

module Devise
end



Devise.add_module :code_authenticatable,
  strategy: true,
  model: 'devise_code_authenticatable/models/code_authenticatable'
