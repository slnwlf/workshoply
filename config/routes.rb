Rails.application.routes.draw do


  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'sites#index'

  # devise
  devise_for :users, skip: [:session, :registration], 
             :controllers => {
              confirmations: "confirmations", 
              passwords: "passwords",
              omniauth_callbacks: "users/omniauth_callbacks"
            }
  devise_scope :user do
    get "/users/cancel", to: "devise/registrations#cancel", as: "cancel_user_registration"
    post "/users", to: "registrations#create", as: "user_registration"
    get "/users/password/edit/:id", to: "devise/registrations#edit", as: "edit_user_password_registration"
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
  get "/contact", to: "sites#contact"

  resources :workshops do 
    resources :reviews
  end

  resources :users, only: [:index, :show, :update, :edit]

  #conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  # mailboxer folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  #incoming message route
  resources :messages, only: [:new, :create]

end
