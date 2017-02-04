Rails.application.routes.draw do
  scope module: :web do
    root to: 'welcome#index'
  end
  namespace :api do
    resources :users, only: [:index]
  end
end
