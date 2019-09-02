# frozen_string_literal: true

Rails.application.routes.draw do
  get 'feedback' => 'static_pages#feedback'
  devise_for :users, controllers: {
                     registrations: 'users/registrations'
                     },
                     skip: [:password]
  resources :users, only: %i[show index]
  resources :posts, only: %i[create destroy] do
    member do
      get 'likers_of' => 'post#likers'
    end
  end
  resources :post_like_brokers, only: [:create, :destroy]
  authenticated :user do
    root 'posts#index'
  end
  unauthenticated :user do
    root 'static_pages#home'
  end
end
