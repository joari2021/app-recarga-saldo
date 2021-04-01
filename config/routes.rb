Rails.application.routes.draw do
  resources :balace_inquiries
  resources :recharge_params
  resources :acoounts
  resources :contacts
  resources :deposits
  resources :recharges
  resources :profiles
  root to: 'home#index'
  get '/dhasboard' => "dashboard#index", :as => :user_root

  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
end
