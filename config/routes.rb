require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  root to: 'articles#index'

  resource :timeline, only: [:show]
  resources :articles 
  
  resources :accounts, only: [:show] do
    resources :posts, only: [:index]
    resources :followers, only: [:index]
    resources :followings, only: [:index]
    resources :follows, only: [:show, :create]
    resources :unfollows, only: [:show, :create]
  end

  resource :profile, only: [:edit, :update]

  namespace :api, defaults: { format: :json } do
    scope '/articles/:article_id' do
      resource :like, only: [:show, :create, :destroy]
      resources :comments, only: [:index, :create, :destroy]
    end
  end

end
