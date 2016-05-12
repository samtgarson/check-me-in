Rails.application.routes.draw do
  resources :transactions
  resources :merchants
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, skip: [:registrations]

  get 'login', to: 'application#login'
  post 'mondo', to: 'application#mondo'
  root to: 'application#home'
end
