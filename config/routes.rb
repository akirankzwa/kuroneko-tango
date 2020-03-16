Rails.application.routes.draw do
  resources :flashcards
  resources :speeches
  root to: 'home#index'
end
