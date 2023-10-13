class Devise::LoginCodesController < DeviseController
  prepend_before_action :allow_params_authentication!, only: :verify

  def verify
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    redirect_to after_sign_in_path_for(resource)

  end

  def show
    @login_code = LoginCode.find(params[:id])
    email = @login_code.resource.email
    self.resource = resource_class.new(email: email)
  end

  def resend
    @login_code = LoginCode.find(params[:id])
    self.resource = @login_code.resource.send_code_login_instructions
    if successfully_sent?(resource)
      redirect_to after_sending_login_code_path_for(resource_name, resource)
    end
  end

  protected
    def auth_options
      :code_authenticatable
    end

    def sign_in_params
      devise_parameter_sanitizer.sanitize(:sign_in)
    end

    def serialize_options(resource)
      methods = resource_class.authentication_keys.dup
      methods = methods.keys if methods.is_a?(Hash)
      methods << :login_code if resource.respond_to?(:login_code)
      { methods: methods, only: [:login_code] }
    end

    def after_sending_login_code_path_for(resource_name, resource)
      login_code_path(resource_name, resource.login_codes.last) if is_navigational_format?
    end
end
