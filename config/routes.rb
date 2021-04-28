Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
  get '/dhasboard' => "dashboard#index", :as => :user_root

  resources :contacts
  get 'buscador_contacts/:names/:operator/:type_payment', to: 'contacts#buscador'

  resources :deposits

  resources :recharge_params
  resources :recharges, except: [:show]
  get 'historial', to: 'recharges#historial'
  get 'process_recharges', to: 'recharges#process_recharges'

  resources :profiles
end
