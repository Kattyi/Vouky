Rails.application.routes.draw do
  resources :dictionaries
  get '/contact', to: 'contact#contact'
  get '/signup',  to: 'users#new'
  get 'welcome/index'
  root 'welcome#index'
end
