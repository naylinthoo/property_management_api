Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :properties do
        get :vacant, on: :collection
        resources :tasks, only: [:index], to: "tasks#property_tasks"
      end
      resources :tasks
    end
  end
end
