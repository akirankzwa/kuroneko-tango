Rails.application.routes.draw do
  resources :speeches
  root to: 'home#index'
end
