Rails.application.routes.draw do

  root to: 'sites#index'

  # devise
  devise_for :users, skip: [:session, :registration], :controllers => {confirmations: "confirmations", passwords: "passwords"}
  devise_scope :user do
    get "/users/cancel", to: "devise/registrations#cancel", as: "cancel_user_registration"
    post "/users", to: "registrations#create", as: "user_registration"
    get "/users/edit", to: "devise/registrations#edit", as: "edit_user_registration"
    patch "/users", to: "devise/registrations#update", as: ""
    put "/users", to: "devise/registrations#update", as: ""
    delete "/users", to: "devise/registrations#destroy", as: ""
    post "/users/sign_in", to: "devise/sessions#create", as: "user_session"
    delete "/users/sign_out", to: "devise/sessions#destroy", as: "destroy_user_session"
    get "/login", to: "devise/sessions#new"
    get "/signup", to: "devise/registrations#new"
  end
  ########

  #home page routes
  get "/about", to: "sites#about"

end
