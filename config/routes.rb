Rails.application.routes.draw do
  resources :groups
  resources :flashcards
  root to: 'home#index'
end
