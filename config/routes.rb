Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
  get '/dashboard' => "dashboard#index", :as => :user_root

  resources :contacts, path: 'clientes_frecuentes'
  
  get 'buscador_contacts/:names/:operator/:type_payment', to: 'contacts#buscador'

  resources :deposits, path: 'registro_compras'
  get 'process_deposits', to: 'deposits#process_deposits'

  resources :recharge_params
  resources :recharges, except: [:show], path: 'vender_recargas'
  get 'historial', to: 'recharges#historial'
  get 'process_recharges', to: 'recharges#process_recharges'

  resources :profiles, path: 'perfil'
  get 'users_all', to: 'profiles#users_all'
end
