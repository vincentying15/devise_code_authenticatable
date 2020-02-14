module ActionDispatch::Routing
  class Mapper

  protected

    def devise_login_code(mapping, controllers)
      resources :login_codes, only: [:show] do
        member do
          post :verify
        end
      end
    end
  end
end
