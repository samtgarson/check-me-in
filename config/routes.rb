Rails.application.routes.draw do
  resources :transactions, only: :create
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:registrations]

  get 'login', to: 'application#login'
  get "/*id" => 'pages#show', as: :page, format: false, constraints: HighVoltage::Constraints::RootRoute
  root to: 'application#home'
end
