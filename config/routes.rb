Rails.application.routes.draw do
  scope module: :web do
    root to: 'welcome#index'

    namespace :admin do
      root to: 'welcome#index'
      resources :dishes, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :user_menus, only: [:index]
      resources :menus, param: :date, only: [:edit, :update]
    end
  end

  namespace :api do
    resources :users, only: [:index, :show, :update] do
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
