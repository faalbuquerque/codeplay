Rails.application.routes.draw do
  root 'home#index'
  resources :courses, only: %i[index show new create edit update destroy]
  resources :teachers, only: %i[index show]
end
