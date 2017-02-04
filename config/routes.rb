Rails.application.routes.draw do
  scope module: :web do
    root to: 'welcome#index'
  end

  namespace :api do
    resources :users, only: [:index, :update] do
      scope module: :users do
        resources :menus, only: [:index]
      end
    end
    resources :dishes, only: [:index, :create, :update, :destroy]
    resources :menus, only: [:index, :create, :update, :destroy]
    resources :user_menus, only: [:index, :update]
  end

  match '*path' => 'web/welcome#index', via: :get
end
