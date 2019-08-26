# frozen_string_literal: true

Rails.application.routes.draw do
  get   'static_pages/home'     => 'static_pages#home'
  get   'static_pages/feedback' => 'static_pages#feedback'
  devise_for :users
  resources :profiles, only: [:show]
  resources :posts, only: %i[create destroy]
  root 'static_pages#home'
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
end
