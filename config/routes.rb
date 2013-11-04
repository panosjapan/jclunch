LunchOrder::Application.routes.draw do

  resources :holidays

  resources :line_items

  get "password_resets/new"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :categories
  resources :menus
  resources :regions
  resources :departments
  resources :orders
  resources :users do
    collection do
      get 'time_cards'
    end
    member do
      get 'time_card'
      post 'download_time_card'
      get 'edit_password'
      put 'update_password'
      put "request_holiday"
      put "unrequest_holiday"
    end
  end
  resources :work_records do
  collection do
    get 'attendance'
  end
end
  resources :sessions
  resources :password_resets
  root :to => 'sessions#new'
  
  #get 'admin' => 'admin#index'
  
  #get 'logout', to: 'sessions#destroy', as: 'logout'

  
  namespace :admin do
  
    
    root :to => 'sessions#new'
    get "menus/index"
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    resources :categories
    resources :users do
      collection do
        get 'time_cards'
      end
      member do
        get 'time_card'
        post 'download_time_card'
        get 'edit_password'
        put 'update_password'
        put "request_holiday"
        put "unrequest_holiday"
      end
    end
    resources :work_records do
      member do
        post 'approve'
        post 'suspend'
      end
      collection do
        get 'monthly'
      end
    end
    resources :menus do
      member do
        put 'toggle'
      end
    end
    resources :regions
    resources :departments
    resources :orders
    resources :sessions
    resources :searches
    scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
      resources :menus
      root to: 'menus#index'
    end
    match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
    match '', to: redirect("/#{I18n.default_locale}")
  end 
  
  namespace :kitchen do
    root :to => 'sessions#new'
    get "menus/index"
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    resources :categories
    resources :users
    resources :menus do
      member do
        put 'toggle'
      end
    end
    resources :regions
    resources :orders
    resources :sessions
    resources :searches
  end
  
end
