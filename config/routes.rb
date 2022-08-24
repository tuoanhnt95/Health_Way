Rails.application.routes.draw do
  # get 'health_checks/index'
  # get 'health_checks/show'
  # get 'health_checks/new'
  # get 'health_checks/edit'
  # get 'set_ups/index'
  # get 'set_ups/show'
  devise_for :users
  root to: "pages#home"

  resources :set_ups, only: %i[index show new create] do
    resources :health_checks, only: %i[new create]
  end

  resources :health_checks, only: %i[index show edit update]
end
