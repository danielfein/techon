Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
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
    get '/pull_new_product/:id', to: 'play#pull_new_product'
    get '/dashboard', to: 'dashboard#index'
    get '/hide/:id', to: 'dashboard#hide'
    get '/unhide/:id', to: 'dashboard#unhide'
    get '/verify', to: 'verify#index'
   get '/verify/:id', to: 'verify#verify'
      get '/skip/:id', to: 'skip#index'

      get '/new', to: 'products#new'

#Stripe
    get '/payola/confirm/:id', to: redirect('/success/%{id}')
    get '/success/:id', to: 'charges#make_charge'
        get '/success', to: 'charges#index'
        get '/charges', to: redirect('/success')

  resources :charges

#For a user's viewing pleasure lol:
    get '/trial', to: 'validate_facebooks#trial'
    get 'play', to: 'play#product'

    get '/my_products', to: 'user_created_products#index'
  resources :products
    get 'sourc', to: 'products#index'
    get 'new_link', to: 'products#new'
    root to: 'play#product'

  mount Payola::Engine => '/payola', as: :payola

end
