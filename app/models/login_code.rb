class LoginCode < ActiveRecord::Base
  include DeviseCodeAuthenticatable::LoginCode
end
