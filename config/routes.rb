DeviseFacebook::Application.routes.draw do
 
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
  
  resources :users, only: [:index, :create, :new]
  resources :user_steps
  resources :relationships, only: [:create, :destroy]
  
  resources :products do
       member { post :vote }
      # member { post :have}
       put :envio_df, on: :member
       put :create, on: :collection
       put :status, on: :collection
  end

  match "list_items/:username" => "users#list_items", :as => "list_items"
  match "followers/:username" => "users#followers", :as => "followers_user"
  match "following/:username" => "users#following", :as => "following_user"
  match "favorites/:username" => "users#favorites", :as => "favorites"
  match "list_projects/:username" => "users#list_projects", :as => "list_projects"
  
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
  match 'preview', to: 'static_pages#preview'
  
 # get users/index
  get '/designer', to: 'users#designer'
  get '/fashionlover', to: 'users#fashionlover'
  get '/boutique', to: 'users#boutique'
  get '/blogger', to: 'users#blogger'
  get '/fotografo', to: 'users#fotografo'
  get '/bio', to: 'users#bio'
  
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

  # profile edit
  match "ubicacion", to: 'users#ubicacion'
  match "perfil", to: 'users#perfil'
  

  match 'publish', to: 'posts#publish'
  resources :posts do
    put :create, on: :collection
    member {post :likes}
  end
  resources :slides
  resources :pictures
  resources :projects do
    put :change_position, on: :member
  end
  get 'tags/:tag', to: 'projects#index', as: :tag
  resources :partners
  resources :pays

  #Customized Routes for Profile Page
  match ":username/edit", :to => "users#edit", :as => "edit_user", :via => :get
  match ":username", :to => "users#show", :as => "user", :via => :get
  match ":username", :to => "users#update", :as => "user", :via => :put
  match ":username", :to => "users#destroy", :as => "user", :via => :delete
end