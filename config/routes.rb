Rails.application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :moods, only: [:new, :create]
  resources :tasks, only: [:index, :new, :create, :update]
  resources :tasks, param: :date, only: [:show, :edit]
end
