Rails.application.routes.draw do
  resources :groups
  resources :flashcards
  resources :speeches
  root to: 'home#index'
end
