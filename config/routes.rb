Rails.application.routes.draw do


  resources :settings
  resources :transactions
  resources :credits
  resources :validate_facebooks
  resources :validate_instagrams
    get '/set_likes/:id', to: 'validate_facebooks#set_likes'
    get '/get_likes/:id', to: 'validate_facebooks#get_likes'
      get '/set_instagram/:id', to: 'validate_instagrams#set_instagram'
          get '/get_instagram/:id', to: 'validate_instagrams#get_instagram'

        get '/trial', to: 'validate_facebooks#trial'

    get 'play', to: 'play#product'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :products
    get 'sourc', to: 'products#index'
    get 'new_link', to: 'products#new'
    root to: 'products#index'

end
