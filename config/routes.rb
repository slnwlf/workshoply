Rails.application.routes.draw do

  devise_for :users
  get 'sites/index'

  root to: 'sites#index'

end
