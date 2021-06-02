Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :courses do
    resources :lessons, only: %i[show new create edit update destroy]
  end

  resources :teachers

  get 'search', to: 'home#search'

  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index show create], param: :code
    end
  end
end
