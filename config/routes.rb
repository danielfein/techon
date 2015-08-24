Rails.application.routes.draw do
  resources :validate_facebooks
    get '/set_likes/:id', to: 'validate_facebooks#set_likes'
    get '/get_likes/:id', to: 'validate_facebooks#get_likes'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :products
    get 'sourc', to: 'products#index'
    get 'new_link', to: 'products#new'
    root to: 'products#index'

end
