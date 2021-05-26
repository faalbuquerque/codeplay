Rails.application.routes.draw do
  root 'home#index'
  resources :courses do
    resources :lessons, only: %i[show new create edit update destroy]
  end

  resources :teachers, only: %i[index show new create edit update]
end
