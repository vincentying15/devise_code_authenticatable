class DeviseCodeAuthenticatable::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters

  def create
    if params[:commit] == "发送验证码"
      resource = resource_class.send_login_code(send_code_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        cookies[:token_sent] = resource.email
        respond_with(resource, location: after_sending_login_code_path_for(resource))
      end
    else
      resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  protected
  def auth_options
    :code_authenticatable
  end

  def after_sending_login_code_path_for(resource)
    new_session_path(resource)
  end

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def send_code_params
    devise_parameter_sanitizer.sanitize(:send_code)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :login_code])
    devise_parameter_sanitizer.permit(:send_code, keys: [:email])
  end
end
