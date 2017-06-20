Rails.application.routes.draw do
  get 'homes/show'

  root    'welcome#index'
  get     'welcome/index'
  get     '/login',         to: 'sessions#new'
  post    '/login',         to: 'sessions#create'
  delete  '/logout',        to: 'sessions#destroy'
  get     '/contact',       to: 'contact#contact'
  get     '/signup',        to: 'users#new'
  get     '/languages',     to: 'languages#index'
  get 'password_resets/new'
  get 'password_resets/edit'

  get 'auth/facebook/callback', to: 'sessions#create'
  get 'auth/failure',           to: redirect('/')

  resources :languages
  resources :dictionaries_categories
  resources :dictionaries
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
