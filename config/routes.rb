Rails.application.routes.draw do
  root 'reports#index'
  resources :reports
  resources :students
  # Auth routes (assuming Devise or custom session)
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
