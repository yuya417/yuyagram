require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  root to: "home#index"

  resource :profile, only: [:show, :edit, :update]
end
