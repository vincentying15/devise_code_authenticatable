module ActionDispatch::Routing
  class Mapper

  protected

    def devise_login_code(mapping, controllers)
      resources :login_codes, only: [:show],
      controller: controllers[:login_codes] do
        member do
          get :resend
          post :verify
        end
      end
    end
  end
end
