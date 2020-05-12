Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "authors#index"
  post "/users/search", to: "users#search"

  resources :books
  resources :authors
  resources :users, only: [:index, :create, :show]
  resources :comments, only: [:create, :update, :destroy]

  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  post "/login", to: "sessions#create"

  get "/signup", to: "users#new", as: :signup

  # namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
  #   resources :books
  # end

  namespace :api, :defaults => {:format => :json} do
    resources :books
    resources :authors
    resources :comments
  end

end
