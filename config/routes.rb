Rails.application.routes.draw do
  resources :dictionaries
  resources :users
  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'
  get     '/contact',     to: 'contact#contact'
  get     '/signup',      to: 'users#new'
  get     'welcome/index'
  root    'welcome#index'
end
