DeviseFacebook::Application.routes.draw do
 
  root :to => 'static_pages#home'
  #root :to => 'static_pages#feed'
   
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'users/sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  
  match '/tags', to: 'tags#show_tags'
  get '/products_all', to: 'products#products_all'
  #----
  
  resources :users, only: [:index, :create, :new]
  resources :user_steps
  resources :relationships, only: [:create, :destroy]
  
  resources :products do
       #member { post :vote }
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

  match "items/:username" => "users#items", :as => "items"
  match "muro/:username" => "users#muro", :as => "muro"
  match "biografia/:username" => "users#biografia", :as => "biografia"
  match 'coleccion/:username' => "users#coleccion", :as => "coleccion"

  #get '/muro', to: 'users#muro'

  resources :feedbacks
  resources :comments
  resources :direction
  resources :notifications
  resources :paintings
  resources :sizes
 # get 'sources/:source', to: 'sources#index', as: :source
  get 'tags/:tag', to: 'microposts#index', as: :tag
  match '/microposts' => 'microposts#index', :as => 'p'
  match '/microposts/:id' => 'microposts#show', :as => 'p'
  match '/microposts/:id/edit' => 'microposts#edit', :as => 'p'
  resources :microposts, :path => "p" do
     member { post :vote}
     member { post :lovs}
  end


  match "microposts_lov/" => "microposts#microposts_lov", :as => "microposts_lov"
  match "microposts_order/" => "microposts#microposts_order", :as => "microposts_order"
  match "microposts_search/" => "microposts#microposts_search", :as => "microposts_search"
  
  
  get '/envio', to: 'products#envio'
  get '/comprar', to: 'products#comprar'
  get '/comprar_login', to: 'products#comprar_login'
  get '/tallas', to: 'products#tallas'
  get '/product_modal', to: 'users#product_modal'
  match 'preview', to: 'static_pages#preview'
  get '/modal_micropost', to: 'microposts#modal_micropost'
  get '/modal_post', to: 'static_pages#modal_post'
  get '/collect', to: 'microposts#collect'
  get '/story', to: 'static_pages#story'
  get 'scrap', to: 'static_pages#scrap'

  
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
  match "registro", to: 'static_pages#registro'
  match "500mx", to: 'five_hundred#fivehundred'

  match "black", to: "static_pages#black"

  match "las7depauline", to:'static_pages#las7depauline'
  match "team", to:'static_pages#team'

  #designers_pages
  match "demo", to: 'static_pages#demo'
  match "men_heute", to: 'static_pages#men_heute'
   get '/modal_item', to: 'static_pages#modal_item'
  match "arbol_viento", to: 'static_pages#arbol_viento'
  

  # profile edit
  match "ubicacion", to: 'users#ubicacion'
  match "perfil", to: 'users#perfil'
  match "notificacion", to: 'users#notificacion'
  

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

  #Testing
  match "feed", to: "static_pages#feed"
  match "index", to: "static_pages#index"


  #ORDENA TU DESMADREEEEEEEEE
  resources :pins
  resources :galleries
  resources :newsletters
  resources :sources
  resources :supports, :only => [:new, :create]

  match "collections/:name" => "galleries#show", :as => "collections"

  resources :groups, only: [:index, :create, :new]

  # Groups Routes
  match "groups/:name/edit", :to => "groups#edit", path: "s/:name/edit", :as => "edit_group", :via => :get
  match "groups/:name", :to => "groups#show", path: "s/:name", :as => "group", :via => :get
  match "groups/:name", :to => "groups#update", path: "s/:name", :as => "group", :via => :put

  match "square/s/:name" => "groups#square", :as => "square"
  match "list/s/:name" => "groups#list", :as => "list"

  # Memberships Routes
  resources :memberships, only: [:create, :destroy]

  # Customized Routes for Profile Page should be at th END
  match ":username/edit", :to => "users#edit", :as => "edit_user", :via => :get
  match ":username", :to => "users#show", :as => "user", :via => :get
  match ":username", :to => "users#update", :as => "user", :via => :put
  match ":username", :to => "users#destroy", :as => "user", :via => :delete

end