Rails.application.routes.draw do
  scope module: :web do
    root to: 'welcome#index'
  end
  namespace :api do
    resources :users, only: [:index] do
      scope module: :users do
        resources :menus, only: [:index]
      end
    end
    resources :dishes, only: [:index, :create, :update, :destroy]
  end
end
