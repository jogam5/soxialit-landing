DeviseFacebook::Application.routes.draw do
 
  resources :paintings

  resources :sizes

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
  #----
  
  resources :users
  resources :user_steps
  resources :relationships, only: [:create, :destroy]

  resources :products do
       member { post :vote }
       member { post :have}
       put :envio_df, on: :member
  end

  resources :feedbacks

  match "list_items/:id" => "users#list_items", :as => "list_items"
  match "followers/:id" => "users#followers", :as => "followers_user"
  match "following/:id" => "users#following", :as => "following_user"
  match "list/:id" => "collections#list", :as => "collections_list"
  match "favorites/:id" => "users#favorites", :as => "favorites"

  resources :comments
  resource :direction
  
  get '/envio', to: 'products#envio'
  get '/comprar', to: 'products#comprar'
  get '/tallas', to: 'products#tallas'
  
  get 'paypal/checkout', to: 'products#paypal_checkout'
  
  get 'mercadopago/checkout', to: 'products#mercadopago_checkout'
  
  get "term", to:'static_pages#term'

    get "privacy", to:'static_pages#privacy'

    get "faq", to:'static_pages#faq'
  
end