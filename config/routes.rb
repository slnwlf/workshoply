Rails.application.routes.draw do

  get 'sites/index'

  root to: 'sites#index'

end
