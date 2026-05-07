Rails.application.routes.draw do
  root 'reports#index'
  resources :reports
  resources :students
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :tags
end
