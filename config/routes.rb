Rails.application.routes.draw do
  resources :dictionaries
  get 'welcome/index'
  root 'welcome#index'
end
