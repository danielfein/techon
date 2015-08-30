Rails.application.routes.draw do


  resources :validate_twitters
  resources :transactions
  resources :credits
  resources :validate_facebooks
  resources :validate_instagrams
    get '/set_likes/:id', to: 'validate_facebooks#set_likes'
    get '/get_likes/:id', to: 'validate_facebooks#get_likes'
    get '/set_instagram/:id', to: 'validate_instagrams#set_instagram'
    get '/get_instagram/:id', to: 'validate_instagrams#get_instagram'
    get '/set_twitter/:id', to: 'validate_twitters#set_twitter'
    get '/get_twitter/:id', to: 'validate_twitters#get_twitter'

#Stripe
    get '/payola/confirm/:id', to: redirect('/success/%{id}')
    get '/success/:id', to: 'charges#make_charge'

  resources :charges

#For a user's viewing pleasure lol:
    get '/trial', to: 'validate_facebooks#trial'
    get 'play', to: 'play#product'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :products
    get 'sourc', to: 'products#index'
    get 'new_link', to: 'products#new'
    root to: 'products#index'

  mount Payola::Engine => '/payola', as: :payola

end
