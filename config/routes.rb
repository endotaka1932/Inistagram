Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  resources :articles do
    resources :comments, only: [:index, :new, :create]
    resource :like, only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:index, :show, :create]
    resources :unfollows, only: [:index, :create]
  end 

  resource :profile, only: [:index, :show, :edit, :update]
  resources :favorites, only: [:index]
  
end
