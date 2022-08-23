Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :set_ups, only: %i[index show new create] do
    resources :health_checks, only: %i[new create]
  end

  resources :health_checks, only: %i[index show edit update]
end
