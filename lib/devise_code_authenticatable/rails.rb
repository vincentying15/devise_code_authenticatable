module DeviseCodeAuthenticatable
  class Engine < ::Rails::Engine

    ActiveSupport.on_load(:action_controller) do
      include DeviseCodeAuthenticatable::Controllers::Helpers
    end

    # We use to_prepare instead of after_initialize here because Devise is a Rails engine; its
    # mailer is reloaded like the rest of the user's app.  Got to make sure that our mailer methods
    # are included each time Devise.mailer is (re)loaded.
    config.to_prepare do
      Devise.mailer.send :include, DeviseCodeAuthenticatable::Mailer
      unless Devise.mailer.ancestors.include?(Devise::Mailers::Helpers)
        Devise.mailer.send :include, Devise::Mailers::Helpers
      end
    end
    # extend mapping with after_initialize because it's not reloaded
    config.after_initialize do
      Devise::ParameterSanitizer.send :prepend, DeviseCodeAuthenticatable::ParameterSanitizer
    end
  end
end
