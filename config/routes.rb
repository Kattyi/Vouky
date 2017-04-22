Rails.application.routes.draw do
  resources :dictionaries
  resources :users
  get '/contact', to: 'contact#contact'
  get '/signup',  to: 'users#new'
  get 'welcome/index'
  root 'welcome#index'
end
