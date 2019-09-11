# frozen_string_literal: true

Rails.application.routes.draw do
  get 'friendships/create'
  get 'friendships/destroy'
  get 'feedback' => 'static_pages#feedback'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  },
                     skip: [:password]
  resources :users, only: %i[show index]
  resources :posts, only: %i[new edit create update destroy]
  resources :comments, only: %i[create destroy]
  resources :post_like_brokers, only: %i[create destroy]
  resources :friendships, only: %i[create update destroy]
  authenticated :user do
    root 'posts#index'
  end
  unauthenticated :user do
    root 'static_pages#home'
  end
end
