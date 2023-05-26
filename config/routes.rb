# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pages, only: [:index, :show]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'

  namespace :admin do
    resources :pages, except: [:show]
    resources :sites, except: [:show]
    resources :sections

    # this is an idea for a solution to adding a link_to_add_nested_fields to a js instance 
    # of a nested fields partial created by a link_to_add_nested_fields link
    # i.e. adding link_to_add_nested_fields within link_to_add_nested_fields without an infinite loop
    # post "/nested_fields/:model(/:id)/build/:association(/:partial)", to: "nested_fields#build", as: :build_fields
  end
end
