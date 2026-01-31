Rails.application.routes.draw do
  resources :posts

  devise_for :users
  resources :users, only: [:show]
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  root 'tweets#index'
end