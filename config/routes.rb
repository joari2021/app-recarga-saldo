Rails.application.routes.draw do
  resources :recharge_params
  resources :acoounts

  resources :contacts
  get 'buscador_contacts/:names/:operator/:type_payment', to: 'contacts#buscador'

  resources :deposits
  resources :recharges, except: [:show]
  get 'historial', to: 'recharges#historial'

  resources :profiles
  root to: 'home#index'
  get '/dhasboard' => "dashboard#index", :as => :user_root

  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
end
