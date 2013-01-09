DeviseFacebook::Application.routes.draw do
 
  resources :pictures

  resources :projects do
    put :change_position, on: :member
  end
  get 'tags/:tag', to: 'projects#index', as: :tag
  
  resources :partners

  resources :pays

  root :to => 'static_pages#home'
 
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'users/sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  #tags
  get "products/tags" => "products#tags", :as => :products_tags
  get 'tags/:tag', to: 'products#index', as: :tag
  match '/tags', to: 'tags#show_tags'
  get '/products_all', to: 'products#products_all'
  #----
  
  resources :users
  resources :user_steps
  resources :relationships, only: [:create, :destroy]
  #Customized Routes for Profile Page
  #match ":username", :to => "users#show",
  #                    :as => "user",
  #                    :via => :get

  resources :products do
       member { post :vote }
       member { post :have}
       put :envio_df, on: :member
       put :create, on: :collection
       put :status, on: :collection
  end

  match "list_items/:id" => "users#list_items", :as => "list_items"
  match "followers/:id" => "users#followers", :as => "followers_user"
  match "following/:id" => "users#following", :as => "following_user"
  match "list/:id" => "collections#list", :as => "collections_list"
  match "favorites/:id" => "users#favorites", :as => "favorites"
  match "list_projects/:id" => "users#list_projects", :as => "list_projects"
  

  resources :feedbacks
  resources :comments
  resource :direction
  resources :paintings
  resources :sizes
  resources :microposts do 
     member { post :lovs}
  end
  
  get '/envio', to: 'products#envio'
  get '/comprar', to: 'products#comprar'
  get '/comprar_login', to: 'products#comprar_login'
  get '/tallas', to: 'products#tallas' 
  
 # get users/index
  get '/designer', to: 'users#designer'
  get '/fashionlover', to: 'users#fashionlover'
  get '/boutique', to: 'users#boutique'
  get '/blogger', to: 'users#blogger'
  get '/fotografo', to: 'users#fotografo'
  
 # get 'paypal/checkout', to: 'products#paypal_checkout'
  get 'paypal/checkout', to: 'pays#paypal_checkout'
  get 'mercadopago/checkout', to: 'products#mercadopago_checkout'

  match "/about", to: 'static_pages#about'
  match "/payment", to: 'static_pages#payment_complete'
  match "soxialit", to: 'static_pages#soxialit'
  match "sell", to: 'static_pages#sell'
  match "buy", to: 'static_pages#buy'
  match "examples", to: 'static_pages#examples'
  match "guides", to: 'static_pages#guides'
  match "term", to:'static_pages#term'
  match "privacy", to:'static_pages#privacy'
  match "faq", to:'static_pages#faq'

  resources :posts
  match 'posts/new_preview', to: 'posts#new_preview'

  resources :slides

end