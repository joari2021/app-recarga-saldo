Rails.application.routes.draw do
  
  get 'contracts/index'
  get 'contracts/show'
  get 'contracts/new'
  get 'contracts/create'
  get 'contracts/edit'
  get 'contracts/update'
  get 'contracts/destroy'
  resources :news
  root to: 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
  get '/dashboard' => "dashboard#index", :as => :user_root

  resources :contacts, path: 'clientes_frecuentes'
  
  get 'buscador_contacts/:operator/:type_payment/:names', to: 'contacts#buscador'

  resources :deposits
  get 'process_deposits', to: 'deposits#process_deposits'

  resources :recharge_params
  resources :recharges, path: 'vender_recargas'
  get 'historial', to: 'recharges#historial'
  get 'process_recharges', to: 'recharges#process_recharges'

  resources :profiles, path: 'perfil'
  get 'users_all', to: 'profiles#users_all'

  resources :system_configurations
  resources :nonexistent_numbers

  get 'balances', to: 'balance#index'
end
