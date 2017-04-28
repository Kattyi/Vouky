Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root    'welcome#index'
  get     'welcome/index'
  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'
  get     '/contact',     to: 'contact#contact'
  get     '/signup',      to: 'users#new'
  get     '/languages',   to: 'languages#index'

  resources :dictionaries
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
