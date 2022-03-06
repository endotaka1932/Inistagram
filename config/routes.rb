require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  resources :articles do
    resources :comments, only: [:index, :new, :create]
    resource :like, only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:show, :create]
    resources :unfollows, only: [:create]
    
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end 

  resource :profile, only: [:index, :show, :edit, :update]
  resource :timeline, only: [:show]
  resources :favorites, only: [:index]
  
end
