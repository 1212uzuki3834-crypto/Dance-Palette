Rails.application.routes.draw do
  get "/test_reg", to: "users/registrations#new"

  root "top#index"

  resources :posts

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resource :mypage, only: [:show], controller: :users

  resources :tags, only: [:create]

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
