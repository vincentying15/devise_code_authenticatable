class DeviseCodeAuthenticatable::SessionsController < Devise::SessionsController

  def create
    self.resource = resource_class.send_code_login_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
    end

    respond_with(resource, location: after_sending_login_code_path_for(resource_name, resource))
  end

  protected
    def auth_options
      :code_authenticatable
    end

    def after_sending_login_code_path_for(resource_name, resource)
      login_code_path(resource_name, resource.login_codes.last) if is_navigational_format?
    end
end
