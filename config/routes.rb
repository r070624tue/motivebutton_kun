Rails.application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :moods, only: [:new, :create]
  resources :tasks, only: [:index, :new, :create, :update] do
    collection do
      patch :bulk_update
    end
  end
  get 'tasks/:date', to: 'tasks#show', as: :task_show
  get 'tasks/:date/edit', to: 'tasks#edit', as: :edit_task_by_date
  resources :advices, only: [:create]
end
