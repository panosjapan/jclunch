LunchOrder::Application.routes.draw do

  get "password_resets/new"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :categories
  resources :menus
  resources :regions
  resources :departments
  resources :orders
  resources :users  
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
    resources :users
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
