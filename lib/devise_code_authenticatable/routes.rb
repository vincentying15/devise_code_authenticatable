module ActionDispatch::Routing
  class Mapper

  protected

    def devise_login_code(mapping, controllers)
      resource :session, only: [], path: "",
      controller: controllers[:sessions] do
        collection do
          get :new, path: mapping.path_names[:sign_in], as: :new
          post :create, path: mapping.path_names[:sign_in]
          delete :destroy, path: mapping.path_names[:sign_out], as: :destroy
        end
      end

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
