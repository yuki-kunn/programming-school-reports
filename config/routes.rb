Rails.application.routes.draw do
  root 'reports#index'
  resources :reports
  resources :students
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :tags

  # Chrome DevTools の自動リクエストを黙って処理（ログエラー抑制）
  get '/.well-known/appspecific/com.chrome.devtools.json',
      to: proc { [200, { 'Content-Type' => 'application/json' }, ['{}']].freeze }
end
