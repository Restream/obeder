require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope module: :web do
    root to: 'welcome#index'

    resources :user, only: [] do
      scope module: :user do
        resource :password, only: [:edit, :update]
      end
    end
    resource :remind_password, only: [:edit, :update]
    resource :session, only: [:new, :create, :destroy]
    get :login, to: 'sessions#new'
    get :logout, to: 'sessions#destroy'

    namespace :admin do
      root to: 'welcome#index'
      resources :dishes, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :user_menus, only: [:index]
      resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :menus, param: :date, only: [:edit, :update] do
        member do
          put :approve
        end
      end
      resources :reports, only: [:index] do
        member do
          get :export
        end
      end
    end
  end

  namespace :api do
    resource :user, only: [:show, :update] do
      scope module: :user do
        resources :menus, only: [:index]
      end
    end
    namespace :admin do
      resources :menus, param: :date do
        member do
          get :validate
        end
      end
    end
    resources :dishes, only: [:index, :create, :update, :destroy]
    resources :menus, only: [:index, :create, :update, :destroy]
    resources :user_menus, only: [:index, :update]
  end

  match '*path' => 'web/welcome#index', via: :get
end
