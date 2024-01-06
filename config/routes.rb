Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/" => "homes#top",as: "top"
  get "/home/about" => "homes#about", as: "about"
  resources :books, only: [:create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :update, :index]
end