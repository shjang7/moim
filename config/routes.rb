# frozen_string_literal: true

Rails.application.routes.draw do
  get 'feedback' => 'static_pages#feedback'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  },
                     skip: [:password]
  resources :users, only: %i[show]
  resources :users, only: %i[index]
  resources :posts, only: %i[create destroy]
  authenticated :user do
    root 'posts#index'
  end
  unauthenticated :user do
    root 'static_pages#home'
  end
end
