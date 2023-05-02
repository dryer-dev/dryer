# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pages, only: [:show]
  devise_for :users
  resources :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'

  namespace :admin do
    resources :pages, except: [:show]
  end
end
