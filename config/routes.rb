Rails.application.routes.draw do
  resources :transactions, only: :create
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:registrations]

  get 'login', to: 'application#login'
  root to: 'application#home'
end
