class Devise::LoginCodesController < DeviseController
  prepend_before_action :allow_params_authentication!, only: :verify

  def verify
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def show
    @login_code = LoginCode.find(params[:id])
    email = @login_code.resource.email
    self.resource = resource_class.new(email: email)
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

end
