Rails.application.routes.draw do
  root    'welcome#index'
  get     'welcome/index'
  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'
  get     '/contact',     to: 'contact#contact'
  get     '/signup',      to: 'users#new'
  resources :dictionaries
  resources :users
  resources :account_activations, only: [:edit]
end
