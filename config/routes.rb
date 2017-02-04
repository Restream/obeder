Rails.application.routes.draw do
  scope module: :web do
    root to: 'welcome#index'
  end
  namespace :api do
    resources :users, only: [:index]
    resources :dishes, only: [:index, :create, :update, :delete]
  end
end
