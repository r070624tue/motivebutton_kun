Rails.application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :tasks, only: [:index, :new, :create, :show]
  resources :moods, only: [:new, :create]
end
