# frozen_string_literal: true

Rails.application.routes.draw do
  get   'home'     => 'static_pages#home'
  get   'feedback' => 'static_pages#feedback'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  },
                     skip: [:password]
  resources :users, only: %i[show]
  resources :users, only: %i[index]
  resources :posts, only: %i[create destroy]
  root 'static_pages#home'
end
